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

#include <ctype.h>

#include "sqldb.h"

/**
 * Throws the entire database contents on stderr, in ASCII.
 *
 * \param db The database context.
 */
void sqldb_debug
  (sqldb_t* db)
{
  DBT key, val;
  unsigned char keydata[ 1024 ];
  unsigned char valdata[ 1024 ];
  unsigned flags = R_FIRST;
  unsigned char* d;
  unsigned i;

  while (1) {
    key.data = keydata;
    val.data = valdata;
    key.size = sizeof(keydata);
    val.size = sizeof(valdata);
    if (db->db->seq(db->db, &key, &val, flags) == 0) {
      fprintf(stderr, "\"");
      d = key.data;
      for (i=0; i < key.size; i++) {
        if (d[ i ] == ' ' || isprint(d[ i ])) {
          fprintf(stderr, "%c", d[ i ]);
        } else {
          fprintf(stderr, "\\x%.2x", d[ i ]);
        }
      }
      fprintf(stderr, "\" => \"");
      d = val.data;
      for (i=0; i < val.size; i++) {
        if (d[ i ] == ' ' || isprint(d[ i ])) {
          fprintf(stderr, "%c", d[ i ]);
        } else {
          fprintf(stderr, "\\x%.2x", d[ i ]);
        }
      }
      fprintf(stderr, "\"\n");
    } else {
      break;
    }
    flags = R_NEXT;
  }
}
