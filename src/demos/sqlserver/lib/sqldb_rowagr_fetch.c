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

static
void sqldb_rowagr_accomodate
  (sqldb_rowagr_t* agr)
{
  if (agr->nrows >= agr->gridheight) {
    agr->gridheight += 8;
    agr->grid = realloc(
      agr->grid,
      sizeof(sqldb_node_t) * agr->fieldlist->nuids * agr->gridheight
    );
  }
}

static
int sqldb_rowagr_fetch_row
  (sqldb_rowagr_t* agr)
{
  unsigned i, j;
  tdt_t key, val;
  unsigned char keydata[ 9 ];
  int rowhasmovedup = 0;

  sqldb_rowagr_accomodate(agr);
  for (i=0; i < agr->fieldlist->nuids; i++) {
    key.data = keydata;
    key.size = sizeof(keydata);
    val.data = NULL;
    val.size = 0;
    if (0 == tdc_nxt(&(agr->cursors[ i ]), &key, &val, TDFLG_ALLOCTDT)) {
      uint32_t fielduid;
      memcpy(&fielduid, &(keydata[ 1 ]), sizeof(uint32_t));
      if (fielduid == agr->fieldlist->uids[ i ]) {
        if (!rowhasmovedup) {
          memmove(
            &(agr->grid[ agr->fieldlist->nuids ]),
            &(agr->grid[ 0 ]),
            sizeof(sqldb_node_t) * agr->fieldlist->nuids * agr->nrows
          );
          rowhasmovedup = 1;
        }
        (agr->nrows)++;
        for (j=0; j < i; j++) {
          agr->grid[ j ] = (sqldb_node_t){
            .fieldname = 0,
            .fielduid = agr->fieldlist->uids[ i ],
            .fieldtype = 0,
            .valuelen = 0,
            .value = 0
          };
        }
        agr->grid[ i ] = (sqldb_node_t){
          .fieldname = 0,
          .fielduid = fielduid,
          .fieldtype = 0,
          .valuelen = val.size,
          .value = val.data
        };
        memcpy(&(agr->grid[ i ].rownumber), &(keydata[ 5 ]), sizeof(uint32_t));
      }
    } else {
      agr->grid[ i ] = (sqldb_node_t){
        .fieldname = 0,
        .fielduid = agr->fieldlist->uids[ i ],
        .fieldtype = 0,
        .valuelen = 0,
        .value = 0
      };
    }
  }
  if (rowhasmovedup) {
    return 0;
  } else {
    return ~0;
  }
}

/**
 * Fetches one row from the row aggregator and returns zero.
 * Or returns non-zero if there aren't anymore rows.
 */
int sqldb_rowagr_fetch
  (sqldb_rowagr_t* agr, sqldb_row_t* row)
{
  if (0 == agr->nrows) {
    if (sqldb_rowagr_fetch_row(agr)) {
      return ~0;
    }
  }
  if (0 == agr->nrows) {
    return ~0;
  }
  row->rownumber = agr->grid[ 0 ].rownumber;
//..
  return 0;
}
