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
 * Takes the action list, and translates it to more a usable actions
 * list in the result structure.
 */
NAIG_ERR_T naie_fill_result
  (
    naie_engine_t* engine,
    naie_result_t* result
  )
{
  unsigned level, j, i, start;
  naie_action_t* a, * b;

  for (i=0; i < engine->actions.size; i++) {
    a = &(engine->actions.entries[ i ]);
    switch (a->action) {
    case NAIG_ACTION_OPENCAPTURE:
      start = a->inputpos;
      level = 1;
      for (j=i+1; j < engine->actions.size; j++) {
        b = &(engine->actions.entries[ j ]);
        switch (b->action) {
        case NAIG_ACTION_OPENCAPTURE:
          ++level;
          break;
        case NAIG_ACTION_CLOSECAPTURE:
          if (level == 0) {
            RETURNERR(NAIE_ERR_ACTIONLIST);
          }
          --level;
          if (level == 0) {
            if (a->slot == b->slot && a->stacklength == b->stacklength) {
              result->actions[ result->size ].action= a->action;
              result->actions[ result->size ].slot = b->slot;
              result->actions[ result->size ].start = start;
              result->actions[ result->size ].length = b->inputpos - start;
              ++(result->size);
              goto EndInnerLoop;
            } else {
#ifdef _DEBUG
              fprintf(stderr, "Close capture of %u found at %u wrong.\n", i, j);
#endif
              RETURNERR(NAIE_ERR_ACTIONLIST);
            }
          }
        default: ;
        }
      }
      break;
    case NAIG_ACTION_DELETE:
    case NAIG_ACTION_REPLACE_CHAR:
    case NAIG_ACTION_REPLACE_QUAD:
      result->actions[ result->size ].action = a->action;
      result->actions[ result->size ].start = a->inputpos;
      result->actions[ result->size ].slot = a->slot;
      result->actions[ result->size ].length = a->intvalue;
      ++(result->size);
      break;
    default: ;
    }
EndInnerLoop: ;
  }
  return NAIG_OK;
}
