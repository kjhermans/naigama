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
 *
 */
NAIG_ERR_T naie_stack_push
  (
    naie_engine_t* engine,
    uint32_t type,
    uint32_t address
  )
{
  if (engine->stack.size < NAIG_MAX_STACK) {
    engine->stack.entries[ engine->stack.size ].type = type;
    engine->stack.entries[ engine->stack.size ].address = address;
    engine->stack.entries[ engine->stack.size ].input_pos = engine->input_pos;
    engine->stack.entries[ engine->stack.size ].actioncount = engine->actions.size;
    ++(engine->stack.size);
    return NAIG_OK;
  }
  RETURNERR(NAIE_ERR_STACKFULL);
}
