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
 * Handler for the 'CREATE TABLE' statement.
 * 
 * \param db     The database context.
 * \param stmt   The statement top parser node.
 * \param result The API result structure which, on success,
 *               will be filled with the result.
 * 
 * \returns Zero on success,
 */
int sqldb_createtable
  (sqldb_t* db, naio_resobj_t* stmt, sqldb_result_t* result)
{
  char* name;
  uint32_t uid;
  unsigned i;

  if (stmt->nchildren >= 3 && stmt->children[ 2 ]->type == SLOTMAP_TABLENAME_) {
    name = stmt->children[ 2 ]->string;
    if (sqldb_table_create(db, name, &uid)) {
      fprintf(stderr, "Could not create table '%s'\n", name);
      return ~0;
    }
    sqldb_result_push_log(result, "Table created '%s'; uid %u", name, uid);
  }
  if (stmt->nchildren >= 5 && stmt->children[ 4 ]->type == SLOTMAP_CREATEFIELDLIST_) {
    for (i=0; i < stmt->children[ 4 ]->nchildren; i++) {
      if (stmt->children[ 4 ]->children[ i ]->type == SLOTMAP_CREATEFIELD_) {
        if (sqldb_createtable_addfield(db, uid, stmt->children[ 4 ]->children[ i ], result)) {
          fprintf(stderr, "Could not create field\n");
          return ~0;
        }
      }
    }
  }
  return 0;
}
