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
int sqldb_row_insert
  (sqldb_t* db, sqldb_row_t* row, sqldb_result_t* result)
{
#ifdef _USE_SLEEPYCAT
  DBT key, val;
#else
  tdt_t key, val;
#endif
  unsigned i;
  unsigned char keydata[ 9 ] = { 'N' };

  key.data = keydata;
  key.size = sizeof(keydata);
  memcpy(&(keydata[ 5 ]), &(row->rownumber), 4);
  for (i=0; i < row->nnodes; i++) {
    memcpy(&(keydata[ 1 ]), &(row->nodes[ i ].fielduid), 4);
    val.data = row->nodes[ i ].value;
    val.size = row->nodes[ i ].valuelen;
#ifdef _USE_SLEEPYCAT
    if (db->db->put(db->db, &key, &val, 0)) {
#else
    if (td_put(&(db->db), &key, &val, 0)) {
#endif
      fprintf(stderr, "Database error.\n");
      return ~0;
    }
  }
  sqldb_result_push_log(result, "1 Row inserted.");
  return 0;
}
