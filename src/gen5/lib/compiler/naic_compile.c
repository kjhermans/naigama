/**
 * This file is part of Raksaka / NAIG,
 * which is a network guard / message parser solution.
 * Copyright 2020, KJ Hermans
 * Written by KJ Hermans <kees.jan.hermans@gmail.com>
 *
 * LICENSE:
 * Withheld
 *
 * \file
 * \brief
 */

#include <sys/types.h>
#include <sys/stat.h>

#include "naic_private.h"

#include <naigama/compiler/naic_grammar.h>

static
const unsigned char bytecode[] = { _BYTECODE_GRAMMAR };

static
NAIG_ERR_T naic_engine_debug_cont
  (naie_engine_t* engine, uint32_t opcode, void* ptr)
{
  (void)ptr;

  if (opcode == 0xffffffff) {
    fprintf(stderr, "======== FAIL\n");
  } else {
    naie_debug_state(engine, 0, 0);
  }
  return NAIG_OK;
}

/**
 *
 */
NAIG_ERR_T naic_compile
  (
    char* grammar,
    naio_slotmap_t* slots,
    unsigned flags,
    NAIG_ERR_T(*fnc)(void*,char*,...),
    void* arg
  )
{
  naic_t naic;
  naie_engine_t engine;
  naio_result_t result;
  naio_resobj_t* object;
  NAIG_ERR_T e;

  CHECK(
    naie_engine_init(
      &engine,
      bytecode,
      sizeof(bytecode),
      (const unsigned char*)grammar,
      strlen(grammar)
    )
  );
  if (flags & NAIC_FLG_DEBUG) {
    struct stat s;
    fprintf(stderr, "Running compiler in debug mode.\n");
    engine.flags |= NAIE_FLAG_DEBUG;
    engine.debugger = naic_engine_debug_cont;
    if (stat("grammar.byc.labelmap", &s) == 0) {
      fprintf(stderr, "Loading labelmap for grammar bytecode.\n");
      CHECK(naie_set_labelmap(&engine, "grammar.byc.labelmap"));
    }
  }
  e = naie_engine_run(&engine, &result);
  if (e.code == 1) { //NAIG_FAILURE) {
    unsigned yx[ 2 ];
    if (strxypos(grammar, engine.input_pos, yx) == 0) {
      fprintf(stderr, "Grammar parsing error line %u, off %u\n", yx[0], yx[1]);
    } else {
      fprintf(stderr, "Grammar parsing error.\n");
    }
    exit(-1);
  }
  memset(&naic, 0, sizeof(naic));
  naic.grammar     = grammar;
  naic.slotmap     = slots;
  naic.labelcount  = 0;
  naic.write       = fnc;
  naic.write_arg   = arg;
  naic.flags       = flags;
  naic.globalscope = NEW(naic_nspnod_t);
  naic.currentscope = naic.globalscope;
  naic.current_buffer = &(naic.write_buffer);
  object = naio_result_object(engine.input, engine.input_length, &result);
  naio_result_object_clean(object, SLOT_S);
  naio_result_object_clean(object, SLOT_BOPEN);
  naio_result_object_clean(object, SLOT_BCLOSE);
  naio_result_object_clean(object, SLOT_CBOPEN);
  naio_result_object_clean(object, SLOT_CBCLOSE);
  naio_result_object_clean(object, SLOT_COMMA);

  e = naic_compile_top(&naic, object);
  if (!NAIG_ISOK(e)) {
    if (strlen(naic.error)) {
      fprintf(stderr, "Compiler error: %s\n", naic.error);
    } else {
      fprintf(stderr, "Compiler error.\n");
    }
    return e;
  }
  CHECK(naic.write(naic.write_arg, "%s", naic.write_buffer.ptr));
  free(naic.write_buffer.ptr);
  return NAIG_OK;
}
