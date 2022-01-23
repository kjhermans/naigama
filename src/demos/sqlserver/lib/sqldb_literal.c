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
int sqldb_literal
  (sqldb_t* db, naio_resobj_t* expr, sqldb_node_t* node)
{
  naio_resobj_t* literal;
  (void)db;

  ASSERT(expr->nchildren)

  literal = expr->children[ 0 ];
  switch (literal->type) {
  case SLOTMAP_STRINGLITERAL_:
    if (sqldb_string_decode(literal, node)) {
      fprintf(stderr, "String decoding error.\n");
      return ~0;
    }
    break;
  case SLOTMAP_BOOLEANLITERAL_:
    node->value = malloc(sizeof(int));
    node->valuelen = sizeof(int);
    if (0 == strcasecmp(literal->string, "true")) {
      *((int*)(node->value)) = 1;
    } else {
      *((int*)(node->value)) = 0;
    }
    break;
  case SLOTMAP_INTLITERAL_:
    node->value = malloc(sizeof(int));
    node->valuelen = sizeof(int);
    *((int*)(node->value)) = atoi(literal->string);
    break;
  case SLOTMAP_FLOATLITERAL_:
    node->value = malloc(sizeof(float));
    node->valuelen = sizeof(float);
    *((float*)(node->value)) = atof(literal->string);
    break;
  default:
    TODO("Implement more literals");
    break;
  }
  return 0;
}
