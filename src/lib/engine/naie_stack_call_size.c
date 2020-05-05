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
 *
 */
unsigned naie_stack_call_size
  (naie_engine_t* engine)
{
  unsigned i, result = 0;

  for (i=0; i < engine->stack.size; i++) {
    if (engine->stack.entries[ i ].type == NAIG_STACK_CALL) {
      ++result;
    }
  }
  return result;
}
