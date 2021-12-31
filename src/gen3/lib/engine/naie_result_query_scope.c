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
 *
 */
NAIG_ERR_T naie_result_query_scope
  (
    naio_result_t* result,
    unsigned result_index,
    unsigned result_scope,
    unsigned* path,
    unsigned path_length,
    unsigned path_index,
    naio_resact_t* action
  )
{
  unsigned occurence_index, current_scope, i;

  if (path_index > path_length - 2) {
    return NAIG_ERR_NOTFOUND;
  }
  occurence_index = path[ path_index + 1 ];
  while (result_index < result_scope) {
    current_scope = result_index + 1;
    for (i = result_index + 1; i < result_scope; i++) {
      current_scope = i;
      if (result->actions[ i ].start >=
          result->actions[ result_index ].start
          + result->actions[ result_index ].length)
      {
        break;
      }
    }
    if (result->actions[ result_index ].slot == path[ path_index ]) {
      if (occurence_index == 0) {
        if (path_index == path_length - 2) {
          *action = result->actions[ result_index ];
          return NAIG_OK;
        } else {
          return naie_result_query_scope(
            result,
            result_index + 1,
            current_scope,
            path,
            path_length,
            path_index + 2,
            action
          );
        }
      } else {
        --occurence_index;
      }
    }
    result_index = current_scope;
  }
  return NAIG_ERR_NOTFOUND;
}
