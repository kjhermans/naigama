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

#include "sqldb.h"

/**
 *
 */
int sqldb_expr5
  (sqldb_t* db, naio_resobj_t* expr, sqldb_node_t* node)
{
  unsigned i;
  sqldb_node_t left, right;

  ASSERT(expr->nchildren)
  memset(&left, 0, sizeof(left));
  if (sqldb_expr6(db, expr->children[ 0 ], &left)) {
    fprintf(stderr, "Expression evaluation failed.\n");
    return ~0;
  }
  for (i=2; i < expr->nchildren; i += 2) {
    if (sqldb_expr6(db, expr->children[ i ], &right)) {
      fprintf(stderr, "Expression evaluation failed.\n");
      return ~0;
    }
    if (expr->children[ i-1 ]->type == SLOTMAP_ADD_) {
//..
    } else if (expr->children[ i-1 ]->type == SLOTMAP_SUB_) {
//..
    }
    //.. free left
    left = right;
  }
  *node = left;
  return 0;
}
