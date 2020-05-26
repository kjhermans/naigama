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

#include "naie_private.h"

/**
 *
 */
NAIG_ERR_T naie_stack_pop
  (naie_engine_t* engine, naie_stackentry_t* entry)
{
  if (engine->stack.size > 0) {
    *entry = engine->stack.entries[ --(engine->stack.size) ];
    return NAIG_OK;
  }
  RETURNERR(NAIE_ERR_STACKEMPTY);
}
