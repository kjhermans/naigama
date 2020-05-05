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

#include <naigama/engine/naie.h>

/**
 *
 */
void naie_debug_actions
  (naie_engine_t* engine)
{
  unsigned i;

  for (i=0; i < engine->actions.size; i++) {
    fprintf(stderr,
      "Action #%u; act=%u, slot=%u, pos=%u, sl=%u, int=%"PRIu64"\n"
      , i
      , engine->actions.entries[ i ].action
      , engine->actions.entries[ i ].slot
      , engine->actions.entries[ i ].inputpos
      , engine->actions.entries[ i ].stacklength
      , engine->actions.entries[ i ].intvalue
    );
  }
}
