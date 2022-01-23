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
 * Initializes a row aggregator, based on a fieldlist.
 * The fieldlist is the result of a select().
 */
void sqldb_rowagr_init
  (sqldb_t* db, sqldb_rowagr_t* agr, sqldb_uidvec_t* fieldlist)
{
  unsigned i;

  memset(agr, 0, sizeof(*agr));
  agr->fieldlist = fieldlist;
#ifdef _USE_SLEEPYCAT
  abort();
#else
  tdt_t key;
  unsigned char keydata[ 5 ] = { 'N' };
  key.data = keydata;
  key.size = sizeof(keydata);
  agr->cursors = malloc(sizeof(tdc_t) * agr->fieldlist->nuids);
  for (i=0; i < agr->fieldlist->nuids; i++) {
    tdc_init(&(db->db), &(agr->cursors[ i ]));
    memcpy(&(keydata[ 1 ]), &(fieldlist->uids[ i ]), sizeof(uint32_t));
    if (tdc_mov(&(agr->cursors[ i ]), &key, TDCFLG_PARTIAL|TDCFLG_EXACT)) {
      //.. no field nodes at all present
    }
  }
#endif
}
