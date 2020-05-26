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

#include "naia_private.h"

static
const unsigned char bytecode[] = ASSEMBLY_BYTECODE;

/**
 *
 */
NAIG_ERR_T naia_assemble
  (
    char* assembly,
    FILE* labelmap,
    int debug,
    NAIG_ERR_T(*write)(void* ptr, unsigned size, void* arg),
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
      (const unsigned char*)assembly,
      strlen(assembly)
    )
  );
  if (debug) { engine.flags |= NAIE_FLAG_DEBUG; }
  e = naie_engine_run(
    &engine,
    &result
  );
  if (e.code == 1) { //NAIG_FAILURE) {
    unsigned yx[ 2 ];
    if (strxypos(assembly, engine.input_pos, yx) == 0) {
      fprintf(stderr, "Assembly parsing error line %u, off %u\n", yx[0], yx[1]);
    } else {
      fprintf(stderr, "Assembly parsing error.\n");
    }
    exit(-1);
  }

  naia_t naia = {
    .assembly     = assembly,
    .captures     = &result,
    .labels.size  = 0,
    .write        = write,
    .write_arg    = arg
  };

  CHECK(naia_process_tokens(&naia));

  if (labelmap) {
    CHECK(naia_label_map_write(&naia, labelmap));
    fclose(labelmap);
  }
  return NAIG_OK;
}
