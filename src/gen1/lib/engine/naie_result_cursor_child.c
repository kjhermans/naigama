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
 * Steps into the first child at the action list cursor.
 */
NAIG_ERR_T naie_result_cursor_child
  (
    naie_rescrs_t* cursor,
    int slot,
    naie_resact_t* action
  )
{
  if (cursor->scope_begin == cursor->scope_end) {
    return NAIG_ERR_NOTFOUND;
  }
  if (cursor->scope_begin + 1 >= cursor->parent_scope_end) {
    return NAIG_ERR_NOTFOUND;
  }
  cursor->parent_scope_begin = cursor->scope_begin;
  cursor->parent_scope_end = cursor->scope_end;
  ++(cursor->scope_begin);
  CHECK(
    naie_result_cursor_scope(
      cursor->result,
      cursor->scope_begin,
      cursor->parent_scope_end,
      &(cursor->scope_end)
    )
  );
  if (slot < 0) {
    *action = cursor->result->actions[ cursor->scope_begin ];
    return NAIG_OK;
  } else if ((unsigned)slot
             == cursor->result->actions[ cursor->scope_begin ].slot)
  {
    *action = cursor->result->actions[ cursor->scope_begin ];
    return NAIG_OK;
  } else {
    CHECK(naie_result_cursor_next(cursor, slot, action));
    return NAIG_OK;
  }
}
