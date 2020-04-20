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

#include <naigama/engine/naie.h>

/**
 * Runs the engine, instead of from the beginning, from a certain
 * symbol in the bytecode, against the input. Precondition is that
 * the labelmap must be loaded, so that the starting bytecode offset
 * can be resolved.
 */
NAIG_ERR_T naie_engine_call_offset
  (
    naie_engine_t* engine,
    uint32_t offset,
    naie_result_t* result
  )
{
  engine->bytecode_pos = offset;
  engine->input_pos = 0;
  CHECK(naie_stack_push(engine, NAIG_STACK_END, 0));
  CHECK(naie_engine_loop(engine, result));
  return NAIG_OK;
}
