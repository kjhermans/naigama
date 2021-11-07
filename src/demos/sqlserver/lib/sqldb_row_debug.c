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
 *
 */
void sqldb_row_debug
  (sqldb_row_t* row)
{
  unsigned i, j;
  unsigned char* str;

  fprintf(stderr, "Row; index=%u, nfields=%u\n", row->rownumber, row->nnodes);
  for (i=0; i < row->nnodes; i++) {
    fprintf(stderr, "Field; name='%s', uid=%u, type=%u, valuelen=%u \""
      , row->nodes[ i ].fieldname
      , row->nodes[ i ].fielduid
      , row->nodes[ i ].fieldtype
      , row->nodes[ i ].valuelen
    );
    for (j=0; j < row->nodes[ i ].valuelen; j++) {
      str = row->nodes[ i ].value;
      if (str[ j ] == ' ' || isprint(str[ j ])) {
        fprintf(stderr, "%c", str[ j ]);
      } else {
        fprintf(stderr, "\\x%.2x", str[ j ]);
      }
    }
    fprintf(stderr, "\"\n");
  }
}
