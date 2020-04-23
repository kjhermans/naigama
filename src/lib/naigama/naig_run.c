/**
 * This file is part of Naigama, a parser engine.
 * Copyright 2020, KJ Hermans
 * Written by KJ Hermans <kees.jan.hermans@gmail.com>
 *
 * LICENSE:
 * Withheld
 *
 * \file
 * \brief
 */

#include <naigama/naigama.h>

/**
 *
 */
NAIG_ERR_T naig_run
  (
    naig_t* naig,
    unsigned char* input,
    unsigned input_length,
    naig_result_t* result
  )
{
  naie_engine_t engine;

  CHECK(
    naie_engine_init(
      &engine,
      naig->bytecode,
      naig->bytecode_length,
      input,
      input_length
    )
  );
  CHECK(naie_engine_run(&engine, (naie_result_t*)result));
  return NAIG_OK;
}
