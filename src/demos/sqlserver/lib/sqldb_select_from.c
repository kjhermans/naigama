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
int sqldb_select_from
  (sqldb_t* db, naio_resobj_t* from, sqldb_uidvec_t* tables)
{
  unsigned i;
  uint32_t tableuid, tablenrows;
  char* tablename;

  ASSERT(from->type == SLOTMAP_SET_)
  for (i=0; i < from->nchildren; i++) {
    ASSERT(from->children[ i ]->type == SLOTMAP_SETELT_)
    if (from->children[ i ]->children[ 0 ]->type == SLOTMAP_TABLENAME_) {
      tablename = from->children[ i ]->children[ 0 ]->children[ 0 ]->string;
      if (sqldb_table_resolve(db, tablename, &tableuid, &tablenrows)) {
        fprintf(stderr, "Table resolving error '%s'\n", tablename);
        return ~0;
      }
      if (sqldb_uidvec_push(tables, tableuid)) {
        fprintf(stderr, "Table list push error.\n");
        return ~0;
      }
    }
  }
  return 0;
}
