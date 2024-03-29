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

#include <naigama/assembler/naia_grammar.h>

static
const unsigned char bytecode[] = { _BYTECODE_ASSEMBLY };

static
NAIG_ERR_T naia_engine_debug_cont
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
NAIG_ERR_T naia_assemble
  (
    char* assembly,
    FILE* labelmap,
    int debug,
    NAIG_ERR_T(*fncwrite)(void* ptr, unsigned size, void* arg),
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
  if (debug) {
    engine.flags |= NAIE_FLAG_DEBUG;
    engine.debugger = naia_engine_debug_cont;
  }
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
    .assembly       = assembly,
    .captures       = &result,
    .labels.entries = malloc(sizeof(naia_labent_t) * 1024),
    .labels.count   = 0,
    .labels.length  = 1024,
    .write          = fncwrite,
    .write_arg      = arg
  };

  CHECK(naia_process_tokens(&naia));

  if (labelmap) {
    CHECK(naia_label_map_write(&naia, labelmap));
    fclose(labelmap);
  }
  return NAIG_OK;
}
