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

#include <inttypes.h>

#include "naie_private.h"

static
char* naie_debug_action_string
  (unsigned action)
{
  switch (action) {
  case NAIG_ACTION_OPENCAPTURE:
    return "Co";
  case NAIG_ACTION_CLOSECAPTURE:
    return "Cc";
  case NAIG_ACTION_DELETE:
    return "Rx";
  case NAIG_ACTION_REPLACE_CHAR:
    return "Rc";
  case NAIG_ACTION_REPLACE_QUAD:
    return "Rq";
  default:
    return "!!";
  }
}

/**
 *
 */
void naie_debug_actions
  (naie_engine_t* engine)
{
  unsigned i;

  for (i=0; i < engine->actions.size; i++) {
    fprintf(stderr,
      "Action #%u; act=%s, slot=%u, pos=%u, sl=%u, int=%"PRIu64"\n"
      , i
      , naie_debug_action_string(engine->actions.entries[ i ].action)
      , engine->actions.entries[ i ].slot
      , engine->actions.entries[ i ].inputpos
      , engine->actions.entries[ i ].stacklength
      , engine->actions.entries[ i ].intvalue
    );
  }
}
