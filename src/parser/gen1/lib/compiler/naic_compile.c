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

#include "naic_private.h"

static
const unsigned char bytecode[] = GRAMMAR_BYTECODE;

/**
 *
 */
NAIG_ERR_T naic_compile
  (
    char* grammar,
    naic_slotmap_t* slots,
    int debug,
    int traps,
    NAIG_ERR_T(*fnc)(void*,char*,...),
    void* arg
  )
{
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
  if (debug) { engine.flags |= NAIE_FLAG_DEBUG; }
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
  naic_t naic = {
    .grammar     = grammar,
    .captures    = &result,
    .capindex    = 0,
    .slotmap     = slots,
    .labelcount  = 0,
    .write       = fnc,
    .write_arg   = arg
  };
  if (traps) {
    naic.flags |= NAIC_FLG_TRAPS;
  }
  CHECK(naic_process_tokens(&naic));
  return NAIG_OK;
}