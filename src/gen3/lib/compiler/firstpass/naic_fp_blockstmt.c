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

#include <string.h>

#include <naigama/engine/naie.h>
#include <naigama/naig_private.h>
#include "../naic_private.h"

/**
 *
 */
NAIG_ERR_T naic_fp_blockstmt
  (naic_t* naic, naio_resobj_t* stmt, naic_nspnod_t* nsp)
{
  ASSERT(naic != NULL)
  ASSERT(stmt != NULL)
  ASSERT(nsp != NULL)

  if (stmt->type != SLOT_BLOCKSTMT && stmt->type != SLOT_FUNCSTMT) {
    return NAIG_OK;
  }
  stmt = stmt->children[ 0 ];

  switch (stmt->type) {
  case SLOT_ST_IF:
    CHECK(naic_fp_stmtif(naic, stmt, nsp));
    break;
  case SLOT_ST_WHILE:
    CHECK(naic_fp_block(naic, stmt->children[ 1 ], nsp));
    break;
  case SLOT_ST_CATCH:
    CHECK(naic_fp_block(naic, stmt->children[ 1 ], nsp));
    break;
  case SLOT_ST_RETURN:
    break;
  case SLOT_ST_LOOPCTL:
    break;
  case SLOT_VARDECL:
    CHECK(naic_fp_vardecl(naic, stmt, nsp));
    break;
  case SLOT_ASSIGNMENT:
    break;
  case SLOT_SCR_EXPRESSION:
    break;
  default:
    fprintf(stderr, "First pass UNKNOWN FUNCTION STMT TYPE %u\n", stmt->type);
    naic_resobj_debug(stmt);
  }
  return NAIG_OK;
}
