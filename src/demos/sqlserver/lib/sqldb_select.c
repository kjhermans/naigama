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

int sqldb_select
  (sqldb_t* db, naio_resobj_t* stmt, sqldb_result_t* result)
{
  naio_resobj_t* what;
  naio_resobj_t* from;
  naio_resobj_t* where = 0;
  sqldb_uidvec_t tablelist;
  sqldb_uidvec_t fieldlist;

  ASSERT(stmt->nchildren >= 4)
  ASSERT(stmt->children[ 1 ]->type == SLOTMAP_SELECTFIELDLIST_)
  ASSERT(stmt->children[ 3 ]->type == SLOTMAP_SET_)
  what = stmt->children[ 1 ];
  from = stmt->children[ 3 ];
  if (stmt->nchildren >= 6 && stmt->children[ 5 ]->type == SLOTMAP_CONDITION_) {
    where = stmt->children[ 5 ];
  }
  sqldb_uidvec_new(&tablelist);
  if (sqldb_select_from(db, from, &tablelist)) {
    fprintf(stderr, "Table list selection error.\n");
    return ~0;
  }
  if (0 == tablelist.nuids) {
    fprintf(stderr, "Table list is empty.\n");
    return ~0;
  }
  sqldb_uidvec_new(&fieldlist);
  if (sqldb_select_fieldlist(db, what, &tablelist, &fieldlist)) {
    fprintf(stderr, "Field list selection error.\n");
    return ~0;
  }
  if (where) {
    //.. produce a condition
  }
  
  TODO("free tablelist, fieldlist")
  return 0;
}
