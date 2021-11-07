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

int sqldb_statement
  (sqldb_t* db, naio_resobj_t* stmt, sqldb_result_t* result)
{
  switch (stmt->type) {
  case SLOTMAP_SELECT_:
    if (sqldb_select(db, stmt, result)) {
      fprintf(stderr, "Select error.\n");
      return ~0;
    }
    break;
  case SLOTMAP_INSERT_:
    if (sqldb_insert(db, stmt, result)) {
      fprintf(stderr, "Insert error.\n");
      return ~0;
    }
    break;
  case SLOTMAP_UPDATE_:
fprintf(stderr, "update\n");
    break;
  case SLOTMAP_DELETE_:
fprintf(stderr, "delete\n");
    break;
  case SLOTMAP_CREATETABLE_:
    if (sqldb_createtable(db, stmt, result)) {
      fprintf(stderr, "Create table error.\n");
      return ~0;
    }
    break;
  case SLOTMAP_DROPTABLE_:
    if (sqldb_droptable(db, stmt, result)) {
      fprintf(stderr, "Drop table error.\n");
      return ~0;
    }
    break;
  case SLOTMAP_GRANT_:
fprintf(stderr, "grant\n");
    break;
  case SLOTMAP_CREATESEQUENCE_:
    if (sqldb_createsequence(db, stmt, result)) {
      fprintf(stderr, "Create sequence error.\n");
      return ~0;
    }
    break;
  case SLOTMAP_DROPSEQUENCE_:
fprintf(stderr, "drop sequence\n");
    break;
  }
  return 0;
}
