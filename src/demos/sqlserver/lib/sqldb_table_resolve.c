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

int sqldb_table_resolve
  (sqldb_t* db, char* name, uint32_t* uid, uint32_t* nrows)
{
  DBT key, val;
  unsigned char keydata[ 5 ] = { 'T' };
  uint32_t type;

  if (sqldb_namespace_get(db, name, uid, &type)) {
    fprintf(stderr, "Could not resolve name '%s'\n", name);
    return ~0;
  }
  if (type != SQLDB_TYPE_TABLE) {
    fprintf(stderr, "Type '%s' is not a table\n", name);
    return ~0;
  }
  memcpy(&(keydata[ 1 ]), uid, 4);
  key.data = keydata;
  key.size = sizeof(keydata);
  val.data = &nrows;
  val.size = sizeof(nrows);
  if (db->db->get(db->db, &key, &val, 0) == 0) {
    (*nrows) = *((uint32_t*)(val.data));
    return 0;
  }
  fprintf(stderr, "Database error.\n");
  return ~0;
}
