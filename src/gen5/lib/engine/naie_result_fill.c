/**
 * This file is part of Naigama, a parser engine.

Copyright (c) 2020, Kees-Jan Hermans <kees.jan.hermans@gmail.com>
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the <organization> nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL Kees-Jan Hermans BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

 *
 * \file
 * \brief
 */

#include "naie_private.h"

/**
 * Takes the action list, and translates it to more a usable actions
 * list in the result structure.
 */
NAIG_ERR_T naie_result_fill
  (
    naie_engine_t* engine,
    naio_result_t* result
  )
{
  unsigned level, j, i, start;
  naie_action_t* a, * b;

  for (i=0; i < engine->actions.count; i++) {
    a = &(engine->actions.entries[ i ]);
    switch (a->action) {
    case NAIG_ACTION_OPENCAPTURE:
      start = a->inputpos;
      level = 1;
      for (j=i+1; j < engine->actions.count; j++) {
        b = &(engine->actions.entries[ j ]);
        switch (b->action) {
        case NAIG_ACTION_OPENCAPTURE:
          ++level;
          break;
        case NAIG_ACTION_CLOSECAPTURE:
          if (level == 0) {
            RETURNERR(NAIG_ERR_ACTIONLIST);
          }
          --level;
          if (level == 0) {
            if (a->slot == b->slot && a->stacklength == b->stacklength) {
              if (result->count == result->length) {
                result->length += 8;
                result->actions = realloc(
                  result->actions,
                  sizeof(naio_resact_t) * result->length
                );
              }
              result->actions[ result->count ].action= a->action;
              result->actions[ result->count ].slot = b->slot;
              result->actions[ result->count ].start = start;
              result->actions[ result->count ].length = b->inputpos - start;
              ++(result->count);
              goto EndInnerLoop;
            } else {
#ifdef _DEBUG
              fprintf(stderr, "Close capture of %u found at %u wrong.\n", i, j);
#endif
              RETURNERR(NAIG_ERR_ACTIONLIST);
            }
          }
        default: ;
        }
      }
      break;
    case NAIG_ACTION_DELETE:
    case NAIG_ACTION_REPLACE_CHAR:
    case NAIG_ACTION_REPLACE_QUAD:
      if (result->count == result->length) {
        result->length += 8;
        result->actions = realloc(
          result->actions,
          sizeof(naio_resact_t) * result->length
        );
      }
      result->actions[ result->count ].action = a->action;
      result->actions[ result->count ].start = a->inputpos;
      result->actions[ result->count ].slot = a->slot;
      result->actions[ result->count ].length = a->intvalue;
      ++(result->count);
      break;
    default: ;
    }
EndInnerLoop: ;
  }
  return NAIG_OK;
}
