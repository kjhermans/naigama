/**
 * This file is part of Raksaka / NAIG,
 * which is a network guard / message parser solution.
 * Copyright 2022, KJ Hermans
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
naie_engine_t engine;

static
int engine_init = 0;

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

NAIG_ERR_T naic_parsetree
  (
    char* grammar,
    naio_resobj_t** object,
    int debug
  )
{
  naio_result_t result;
  NAIG_ERR_T e;

  if (engine_init == 0) {
    CHECK(
      naie_engine_init(
        &engine,
        bytecode,
        sizeof(bytecode)
      )
    );
    engine_init = 0;
  }
  if (debug) {
    struct stat s;
    fprintf(stderr, "Running compiler in debug mode.\n");
    engine.flags |= NAIE_FLAG_DEBUG;
    engine.debugger = naic_engine_debug_cont;
    if (stat("grammar.byc.labelmap", &s) == 0) {
      fprintf(stderr, "Loading labelmap for grammar bytecode.\n");
      CHECK(naio_labelmap_load(&(engine.labelmap), "grammar.byc.labelmap"));
    }
  } else {
    engine.flags &= ~NAIE_FLAG_DEBUG;
    engine.debugger = 0;
  }
  e = naie_engine_run(
        &engine,
        (const unsigned char*)grammar,
        strlen(grammar),
        &result
  );
  if (e.code) {
    unsigned yx[ 2 ];
    if (strxypos(grammar, engine.input_pos, yx) == 0) {
      fprintf(stderr,
        "Grammar parsing error (%d) line %u, off %u\n", e.code, yx[0], yx[1]
      );
    } else {
      fprintf(stderr, "Grammar parsing error (%d).\n", e.code);
    }
    return e;
  }
  *object = naio_result_object(engine.input, engine.input_length, &result);
  naio_result_object_clean(*object, SLOT_S);
  naio_result_object_clean(*object, SLOT_COMMENT);
  naio_result_object_clean(*object, SLOT_MULTILINECOMMENT);
  naio_result_object_clean(*object, SLOT_BOPEN);
  naio_result_object_clean(*object, SLOT_BCLOSE);
  naio_result_object_clean(*object, SLOT_CBOPEN);
  naio_result_object_clean(*object, SLOT_CBCLOSE);
  naio_result_object_clean(*object, SLOT_COLON);
  naio_result_object_clean(*object, SLOT_LEFTARROW);
  naio_result_object_clean(*object, SLOT_OR);
/*
  naio_result_object_clean(*object, SLOT_END);
  naio_result_object_clean(*object, SLOT_ABOPEN);
  naio_result_object_clean(*object, SLOT_ABCLOSE);
*/
  naie_engine_free(&engine);
  naie_result_free(&result);
  return NAIG_OK;
}
