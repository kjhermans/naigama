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
 * Callback API for the action list.
 * Iterates through the action list and calls caller provided functions
 * along the way.
 */
NAIG_ERR_T naie_result_handle
  (
    naie_engine_t* engine,
    naie_result_t* result,
    naie_capture_t capturefnc,
    naie_delete_t deletefnc,
    naie_insert_t insertfnc,
    void* arg
  )
{
  unsigned i, j;
  naie_result_t r = *result;
  int delta;
  uint32_t slot;

  for (i=0; i < r.count; i++) {
    switch (r.actions[ i ].action) {
    case NAIG_ACTION_OPENCAPTURE:
      if (capturefnc) {
        CHECK(
          capturefnc(
            (engine ? engine->input : 0),
            r.actions[ i ].start,
            r.actions[ i ].length,
            arg
          )
        );
      }
      break;
    case NAIG_ACTION_DELETE:
      if (deletefnc) {
        delta = r.actions[ i ].length;
        CHECK(
          deletefnc(
            (engine ? engine->input : 0),
            r.actions[ i ].start,
            r.actions[ i ].length,
            arg
          )
        );
        for (j=i+1; j < r.count; j++) {
          r.actions[ j ].start -= delta;
        }
      }
      break;
    case NAIG_ACTION_REPLACE_CHAR:
    case NAIG_ACTION_REPLACE_QUAD:
      slot = r.actions[ i ].slot;
      for (; i < r.count; i++) {
        if ((r.actions[ i ].action == NAIG_ACTION_REPLACE_CHAR
             || r.actions[ i ].action == NAIG_ACTION_REPLACE_QUAD)
            && r.actions[ i ].slot == slot)
        {
          if (insertfnc) {
            CHECK(
              insertfnc(
                (engine ? engine->input : 0),
                r.actions[ i ].action,
                r.actions[ i ].start,
                r.actions[ i ].length,
                arg
              )
            );
            for (j=i+1; j < r.count; j++) {
              r.actions[ j ].start +=
                (r.actions[ i ].action == NAIG_ACTION_REPLACE_CHAR ? 1 : 4);
            }
          }
        } else {
          --i;
          break;
        }
      }
      break;
    }
  }
  return NAIG_OK;
}
