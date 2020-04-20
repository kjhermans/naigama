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

#include <naigama/compiler/naic.h>

static
const unsigned char bytecode[] = GRAMMAR_BYTECODE;

/**
 *
 */
NAIG_ERR_T naic_compile
  (char* grammar, FILE* output, naic_slotmap_t* slots, int debug, int traps)
{
  naie_engine_t engine;
  naie_result_t result;
  NAIG_ERR_T e;

  CHECK(
    naie_engine_init(
      &engine,
      bytecode,
      sizeof(bytecode),
      (unsigned char*)grammar,
      strlen(grammar)
    )
  );
  engine.debug = debug;
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
  CHECK(naic_process_tokens(grammar, &result, output, slots, traps));
  return NAIG_OK;
}
