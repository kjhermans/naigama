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

#include "naic_private.h"

static
NAIG_ERR_T naic_process_function_param
  (naic_t* naic, naie_rescrs_t* cursor)
{
  char param[ 65 ];
  naie_rescrs_t subcursor = *cursor;
  naie_resact_t action;

  CHECK(naie_result_cursor_child(&subcursor, SLOT_PARAMDECL_IDENT_2, &action));
  CHECK(naie_result_cursor_string(&subcursor, naic->grammar, param, sizeof(param)));
  CHECK(naic->write(naic->write_arg, "-- Parameter %s\n", param));
  //..
  return NAIG_OK;
}

/**
 *
 */
NAIG_ERR_T naic_process_function_params
  (naic_t* naic, naie_rescrs_t* cursor)
{
  naie_resact_t action;

  CATCHOUT(
    naie_result_cursor_child(cursor, SLOT_FUNCPARAMDECL_PARAMDECL, &action),
    NAIG_ERR_NOTFOUND
  );
  CHECK(naic_process_function_param(naic, cursor));
  while (1) {
    CATCHOUT(
      naie_result_cursor_next(cursor, SLOT_FUNCPARAMDECL_PARAMDECL_1, &action),
      NAIG_ERR_NOTFOUND
    );
    CHECK(naic_process_function_param(naic, cursor));
  }
  return NAIG_OK;
}