/**
 * This file is part of NAIG.
 * Copyright 2019, KJ Hermans
 * Written by KJ Hermans <kees.jan.hermans@gmail.com>
 *
 * LICENSE:
 * Withheld
 *
 * \file
 * \brief
 */

#include <naigama/engine/naie.h>

/**
 * Runs the bytecode, from the beginning, against the input,
 * also from the beginning. Ends when either a FAIL condition
 * eats up the entire stack (no match), or the 'end' instruction
 * is encountered (natch). Or an abnormal situation is encountered.
 *
 * \param engine  Initialized engine
 * \param result  Uninitialized result, contains all relevant
 *                end code / capture data / replace data
 *                when this function returns.
 * \returns       NAIG_OK on success, NAIG_FAILURE on no match, or
 *                any other error on abnormal end.
 */
NAIG_ERR_T naie_engine_run
  (
    naie_engine_t* engine,
    naie_result_t* result
  )
{
  engine->bytecode_pos = 0;
  engine->input_pos = 0;
  CHECK(naie_engine_loop(engine, result));
  return NAIG_OK;
}
