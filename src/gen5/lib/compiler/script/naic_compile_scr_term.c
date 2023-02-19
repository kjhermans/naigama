/**
 * This file is part of Oroszlan, a parsing and scripting environment

Copyright (c) 2021, Kees-Jan Hermans <kees.jan.hermans@gmail.com>
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the organization nor the
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

#include "../naic_private.h"

/**
 *
 */
NAIG_ERR_T naic_compile_scr_term
  (naic_t* naic, naio_resobj_t* term)
{
//fprintf(stderr, "-- term\n");
//naic_resobj_debug(term);
//fprintf(stderr, "-- /term\n");

  switch (term->children[ 0 ]->type) {
  case SLOT_FUNCTIONCALL:
    CHECK(naic_compile_functioncall(naic, term->children[ 0 ]));
    break;
  case SLOT_LITERAL:
    switch (term->children[ 0 ]->children[ 0 ]->type) {
    case SLOT_INTLITERAL:
    case SLOT_FLOATLITERAL:
    case SLOT_BOOLEANLITERAL:
      NAIC_WRITE("  scr_push %s\n", term->children[ 0 ]->children[ 0 ]->string);
      break;
    }
    break;
  case SLOT_SCR_EXPRESSION:
    CHECK(naic_compile_expr(naic, term->children[ 0 ]));
    break;
  case SLOT_SCR_UREFERENCE:
    TODO("Filter out the unops");
    CHECK(naic_compile_scr_reference(naic, term->children[ 0 ]->children[ 0 ]));
    break;
  }

  return NAIG_OK;
}
