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

/**
 *
 */
NAIG_ERR_T naic_compile_expr
  (naic_t* naic, naie_resobj_t* expr)
{
  unsigned i;

  for (i=0; i < expr->nchildren; i++) {
    switch (expr->children[ i ]->type) {
    case SLOT_BINOP_P04_ADDSUBBINOPPSCRTERM:
      CHECK(naic_compile_expr(naic, expr->children[ i ]));
      switch (expr->children[ i ]->children[ 0 ]->type) {
      case SLOT_ADD:
        CHECK(naic->write(naic->write_arg, "  __s:add\n"));
        break;
      case SLOT_SUB:
        CHECK(naic->write(naic->write_arg, "  __s:sub\n"));
        break;
      }
      break;
    case SLOT_BINOP_P03_MULDIVPOWSCRTERM:
      CHECK(naic_compile_expr(naic, expr->children[ i ]));
      switch (expr->children[ i ]->children[ 0 ]->type) {
      case SLOT_MUL:
        CHECK(naic->write(naic->write_arg, "  __s:mul\n"));
        break;
      case SLOT_DIV:
        CHECK(naic->write(naic->write_arg, "  __s:div\n"));
        break;
      case SLOT_POW:
        CHECK(naic->write(naic->write_arg, "  __s:pow\n"));
        break;
      }
      break;
    case SLOT_SCR_TERM_FUNCTIONCALL:
      CHECK(naic_compile_expr_call(naic, expr->children[ i ]));
      break;
    case SLOT_SCR_TERM_LITERAL:
      CHECK(naic_compile_expr_literal(naic, expr->children[ i ]));
      break;
    case SLOT_SCR_TERM_SCRREFERENCE:
      CHECK(naic_compile_expr_reference(naic, expr->children[ i ]));
      break;
    default:
      //fprintf(stderr, "TYPE: %u\n", expr->children[ i ]->type);
      break;
    }
  }
  return NAIG_OK;
}
