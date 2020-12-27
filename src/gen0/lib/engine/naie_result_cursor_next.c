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
DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
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
 * Steps to the next item at the same level in the action list cursor.
 *
 * \param cursor The cursor
 * \param slot   When -1, gives you the next sibling
 *               regardless of slot (token type) value.
 *               Otherwise, asserts that the next
 *               sibling is of this type.
 * \param action Result in case of success (may be NULL).
 */
NAIG_ERR_T naie_result_cursor_next
  (
    naie_rescrs_t* cursor,
    int slot,
    naie_resact_t* action
  )
{
  unsigned i;
  naie_resact_t* r0, * r1;
 
  if (cursor->index >= cursor->result->count) {
    return NAIG_ERR_NOTFOUND;
  }
  r0 = &(cursor->result->actions[ cursor->index ]);
  for (i = cursor->index + 1; i < cursor->result->count; i++) {
    r1 = &(cursor->result->actions[ i ]);
    if (r1->start >= r0->start + r0->length) {
      if ((unsigned)slot == r1->slot) {
        cursor->index = i;
        if (action) { *action = *r1; }
        return NAIG_OK;
      } else {
        return NAIG_ERR_NOTFOUND;
      }
    }
  }
  return NAIG_ERR_NOTFOUND;
}
