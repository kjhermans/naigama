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
NAIG_ERR_T naie_variable
  (
    naie_engine_t* engine,
    const unsigned char* data,
    uint32_t slot,
    unsigned char** value,
    unsigned* valuesize
  )
{
  unsigned i = engine->actions.size;
  naie_action_t* c = &(engine->actions.entries[ i ]);
  unsigned start, stop;
  int stopfound = 0, startfound = 0;

  while (i > 0) {
    --i;
    c = &(engine->actions.entries[ i ]);
    if (c->slot == slot && engine->stack.size == c->stacklength) {
      if (c->action == NAIG_ACTION_OPENCAPTURE && stopfound) {
        start = c->inputpos;
        startfound = 1;
      } else if (c->action == NAIG_ACTION_CLOSECAPTURE) {
        stop = c->inputpos;
        stopfound = 1;
      }
    }
  }
  if (startfound && stopfound && stop > start) {
    *value = (unsigned char*)data + start;
    *valuesize = stop - start;
    return NAIG_OK;
  }
  RETURNERR(NAIE_ERR_VARIABLE);
}
