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
 * Gets all fields for a table
 */
int sqldb_field_list
  (sqldb_t* db, uint32_t tableuid, sqldb_uidvec_t* list)
{
  DBT key, val;
  unsigned char keydata[ 5 ] = { 'A' }, *_kd, *_vd;
  uint32_t valdata[ 2 ];
  unsigned flags = R_CURSOR;

  memcpy(&(keydata[ 1 ]), &tableuid, 4);
  key.data = keydata;
  key.size = sizeof(keydata);
  val.data = valdata;
  val.size = sizeof(valdata);
  while (1) {
    if (db->db->seq(db->db, &key, &val, flags) == 0) {
      _kd = key.data;
      _vd = val.data;
      if (key.size >= 5 && _kd[ 0 ] == 'A' && *((uint32_t*)(&(_kd[1]))) == tableuid) {
        if (sqldb_uidvec_push(list, *((uint32_t*)_vd))) {
          fprintf(stderr, "Error push field UID.\n");
          return ~0;
        }
      } else {
        break;
      }
    } else {
      break;
    }
    flags = R_NEXT;
  }
  return 0;
}
