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
 * Handler for the 'CREATE SEQUENCE' statement.
 *
 * \param db     The database context.
 * \param stmt   The statement top parser node.
 * \param result The API result structure which, on success,
 *               will be filled with the result.
 *
 * \returns Zero on success, 
 */
int sqldb_createsequence
  (sqldb_t* db, naio_resobj_t* stmt, sqldb_result_t* result)
{
  char* name;
  uint32_t uid;

  ASSERT(stmt->nchildren >= 3)
  ASSERT(stmt->children[ 2 ]->type == SLOTMAP_SEQNAME_)
  name = stmt->children[ 2 ]->string;
  if (sqldb_sequence_create(db, name, 1, &uid)) {
    fprintf(stderr, "Could not create sequence '%s'\n", name);
    return ~0;
  }
  sqldb_result_push_log(result, "Sequence created '%s'; uid %u", name, uid);
  return 0;
}
