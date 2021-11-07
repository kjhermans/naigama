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

#include <sys/types.h>
#include <limits.h>
#include <fcntl.h>

#include "sqldb.h"

#include "bytecode.h"

static unsigned char bytecode[] = {
  _BYTECODE_GRAMMAR
};

int sqldb_init
  (sqldb_t* db, char* path)
{
  DBT key, val;
  unsigned char keydata = 'D';
  char* valdata = "SQLDB";

  memset(db, 0, sizeof(*db));
  if ((db->db = dbopen(path, O_RDWR|O_CREAT, 0644, DB_BTREE, NULL)) == NULL) {
    fprintf(stderr, "Could not open database at '%s'\n", path);
    return ~0;
  }
  key.data = &keydata;
  key.size = 1;
  val.data = valdata;
  val.size = strlen(valdata);
  if (db->db->put(db->db, &key, &val, 0)) {
    fprintf(stderr, "Database error\n");
    return ~0;
  }
  SQL_CHECK_NAIG(naie_engine_init(&(db->parser), bytecode, sizeof(bytecode), NULL, 0));
  db->init = 1;
  return 0;
}
