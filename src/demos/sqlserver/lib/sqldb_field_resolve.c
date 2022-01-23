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

int sqldb_field_resolve
  (sqldb_t* db, uint32_t tableuid, char* name, uint32_t* uid, uint32_t* type)
{
#ifdef _USE_SLEEPYCAT
  DBT key, val;
#else
  tdt_t key, val;
#endif
  unsigned char keydata[ 5 ] = { 'F' };
  uint32_t dbtype;

  if (sqldb_namespace_get_h(db, tableuid, name, uid, &dbtype)) {
    fprintf(stderr, "Could resolve field name '%s'\n", name);
    return ~0;
  }
  if (dbtype != SQLDB_TYPE_FIELD) {
    fprintf(stderr, "Namespace item '%s' is not a field\n", name);
    return ~0;
  }
  memcpy(&(keydata[ 1 ]), uid, 4);
  key.data = keydata;
  key.size = sizeof(keydata);
  val.data = type;
  val.size = sizeof(*type);
#ifdef _USE_SLEEPYCAT
  if (db->db->get(db->db, &key, &val, 0) == 0) {
#else
  if (td_get(&(db->db), &key, &val, 0) == 0) {
#endif
    (*type) = *((uint32_t*)(val.data));
    return 0;
  }
  fprintf(stderr, "Database error.\n");
  return ~0;
}
