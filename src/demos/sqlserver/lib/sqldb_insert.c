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

int sqldb_insert
  (sqldb_t* db, naio_resobj_t* stmt, sqldb_result_t* result)
{
  char* tablename;
  uint32_t uid;
  uint32_t nrows;
  naio_resobj_t* fieldlist;
  naio_resobj_t* valuelist;
  sqldb_row_t row;
 
  ASSERT(stmt->nchildren >= 3 && stmt->children[ 2 ]->type == SLOTMAP_TABLENAME_)
  tablename = stmt->children[ 2 ]->children[ 0 ]->string;
  if (sqldb_table_resolve(db, tablename, &uid, &nrows)) {
    fprintf(stderr, "Table error '%s'.\n", tablename);
    return ~0;
  }
  sqldb_row_new(&row, nrows);
  ASSERT(stmt->nchildren >= 5 && stmt->children[ 4 ]->type == SLOTMAP_INSERTFIELDLIST_)
  fieldlist = stmt->children[ 4 ];
  if (sqldb_insert_fieldlist(db, uid, fieldlist, &row)) {
    fprintf(stderr, "Error preparing row using fieldlist for table '%s'\n", tablename);
    return ~0;
  }
  ASSERT(stmt->nchildren >= 9 && stmt->children[ 8 ]->type == SLOTMAP_INSERTVALUELIST_)
  valuelist = stmt->children[ 8 ];
  if (sqldb_insert_assignvalues(db, valuelist, &row)) {
    fprintf(stderr, "Error assiging values for table '%s'\n", tablename);
    return ~0;
  }

  sqldb_row_debug(&row);

  if (sqldb_row_insert(db, &row, result)) {
    fprintf(stderr, "Row insertion error.\n");
    return ~0;
  }
  ++nrows;
  if (sqldb_table_update(db, uid, nrows)) {
    fprintf(stderr, "Table update error.\n");
    return ~0;
  }
  sqldb_row_free(&row);

  return 0;
}
