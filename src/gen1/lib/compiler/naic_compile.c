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

static
const unsigned char bytecode[] = GRAMMAR_BYTECODE;

static
NAIG_ERR_T naic_engine_debug_cont
  (naie_engine_t* engine, uint32_t opcode, void* ptr)
{
  (void)ptr;

  if (opcode == 0xffffffff) {
    fprintf(stderr, "======== FAIL\n");
  } else {
    naie_debug_state(engine, 0);
  }
  return NAIG_OK;
}

/**
 *
 */
NAIG_ERR_T naic_compile
  (
    char* grammar,
    naic_slotmap_t* slots,
    unsigned flags,
    NAIG_ERR_T(*fnc)(void*,char*,...),
    void* arg
  )
{
  naic_t naic;
  naie_engine_t engine;
  naie_result_t result;
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
  naic.captures    = &result;
  naic.capindex    = 0;
  naic.slotmap     = slots;
  naic.labelcount  = 0;
  naic.write       = fnc;
  naic.write_arg   = arg;
  naic.flags       = flags;
  if (!NAIG_ISOK(naic_process_tokens(&naic))) {
    if (strlen(naic.error)) {
      fprintf(stderr, "Compiler error: %s\n", naic.error);
    } else {
      fprintf(stderr, "Compiler error.\n");
    }
    return NAIG_FAILURE;
  }
  return NAIG_OK;
}
