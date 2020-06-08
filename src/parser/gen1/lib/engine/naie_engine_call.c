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

#include "naie_private.h"

/**
 * Runs the engine, instead of from the beginning, from a certain
 * symbol in the bytecode, against the input. Precondition is that
 * the labelmap must be loaded, so that the starting bytecode offset
 * can be resolved.
 */
NAIG_ERR_T naie_engine_call
  (
    naie_engine_t* engine,
    char* label,
    naie_result_t* result
  )
{
  uint32_t offset;

  CHECK(naie_labelmap_get(engine, label, &offset));
  CHECK(naie_engine_call_offset(engine, offset, result));
  return NAIG_OK;
}
