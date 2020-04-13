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

#include <naigama/assembler/naia.h>

static
const unsigned char bytecode[] = ASSEMBLY_BYTECODE;

/**
 *
 */
NAIG_ERR_T naia_assemble
  (char* assembly, FILE* output, int debug)
{
  naie_engine_t engine;
  naie_result_t result;
  NAIG_ERR_T e;

  CHECK(naie_engine_init(&engine));
  engine.debug = debug;
  e = naie_engine_run(
    &engine,
    bytecode,
    sizeof(bytecode),
    (unsigned char*)assembly,
    strlen(assembly),
    &result
  );
  if (e.code == 1) { //NAIG_FAILURE) {
    unsigned yx[ 2 ];
    if (strxypos(assembly, engine.inputpos, yx) == 0) {
      fprintf(stderr, "Assembly parsing error line %u, off %u\n", yx[0], yx[1]);
    } else {
      fprintf(stderr, "Assembly parsing error.\n");
    }
    exit(-1);
  }
  CHECK(naia_process_tokens(assembly, &result, output));
  return NAIG_OK;
}
