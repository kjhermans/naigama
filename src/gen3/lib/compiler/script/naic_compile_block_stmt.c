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

#include "../naic_private.h"

/**
 *
 */
NAIG_ERR_T naic_compile_block_stmt
  (naic_t* naic, naio_resobj_t* stmt)
{
  char label[ 64 ];

  if (stmt->type != SLOT_BLOCKSTMT) {
    return NAIG_OK;
  }
  stmt = stmt->children[ 0 ];

  switch (stmt->type) {
  case SLOT_ST_IF:
    CHECK(naic_compile_if(naic, stmt));
    break;
  case SLOT_ST_WHILE:
    CHECK(naic_compile_while(naic, stmt));
    break;
  case SLOT_ST_CATCH:
    break;
  case SLOT_ST_RETURN:
    CHECK(naic_compile_return(naic, stmt));
    break;
  case SLOT_ST_LOOPCTL:
    if (stmt->children[ 0 ]->type == SLOT_KW_BREAK) {
      snprintf(label, sizeof(label),
        "__WHILE_OUT_%u", naic->currentscope->scopelabel
      );
      NAIC_WRITE("  jump %s\n", label);
    } else if (stmt->children[ 0 ]->type == SLOT_KW_CONTINUE) {
      snprintf(label, sizeof(label),
        "__WHILE_TOP_%u", naic->currentscope->scopelabel
      );
      NAIC_WRITE("  jump %s\n", label);
    }
    break;
  case SLOT_VARDECL:
    CHECK(naic_compile_vardecl(naic, stmt));
    break;
  case SLOT_ASSIGNMENT:
    CHECK(naic_compile_assignment(naic, stmt));
    break;
  case SLOT_SCR_EXPRESSION:
    CHECK(naic_compile_expr(naic, stmt));
    NAIC_WRITE("  scr_pop -- pop the end off the expression\n");
    break;
  default:
    fprintf(stderr, "Second pass UNKNOWN FUNCTION STMT TYPE %u\n", stmt->type);
    naic_resobj_debug(stmt);
  }
  return NAIG_OK;
}
