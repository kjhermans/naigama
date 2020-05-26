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
NAIG_ERR_T naie_action_push
  (naie_engine_t* engine, naie_action_t action)
{
  if (engine->actions.size >= NAIG_MAX_ACTIONS) {
    RETURNERR(NAIE_ERR_ACTIONFULL);
  }
//  action.inputpos = engine->input_pos;
  action.stacklength = naie_stack_call_size(engine);
  engine->actions.entries[ engine->actions.size ] = action;
  (engine->actions.size)++;
  return NAIG_OK;
}
