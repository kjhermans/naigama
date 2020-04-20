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
 * the labelmap must be loaded.
 */
NAIG_ERR_T naie_engine_call
  (
    naie_engine_t* engine,
    char* label,
    naie_result_t* result
  )
{
  //..
}
