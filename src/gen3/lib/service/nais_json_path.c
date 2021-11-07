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

#include "nais_private.h"

/**
 *
 */
NAIG_ERR_T nais_json_path
  (naio_resobj_t* o, unsigned nelts, char* elts[], naio_resobj_t** result)
{
  unsigned i;
  naio_resobj_itelt_t* query;

naio_resobj_debug(o, 0);
  if (nelts == 0) {
    *result = 0;
    return NAIG_OK;
  }
  query = (naio_resobj_itelt_t[]){
    {
      .flags = (NAIO_RESOBJ_FLAG_SLOT),
      .query.slot = SLOTMAP_JSON,
    },
    {
      .flags = (NAIO_RESOBJ_FLAG_SLOT),
      .query.slot = SLOTMAP_HASH,
    },
    {
      .flags = (NAIO_RESOBJ_FLAG_SLOT),
      .query.slot = SLOTMAP_HASHELTS,
    },
    {
      .flags = (NAIO_RESOBJ_FLAG_SLOT),
      .query.slot = SLOTMAP_HASHELT,
    },
    {
      .flags = (NAIO_RESOBJ_FLAG_SLOT),
      .query.slot = SLOTMAP_STRING,
    },
    {
      .flags = (NAIO_RESOBJ_FLAG_SLOT |
                NAIO_RESOBJ_FLAG_STRING |
                NAIO_RESOBJ_FLAG_UPONSUCCESS),
      .query.slot = SLOTMAP_STRINGCONTENT,
      .query.string = elts[ 0 ],
      .uponsuccess = 2
    },
    {
      .flags = (NAIO_RESOBJ_FLAG_SLOT),
      .query.slot = SLOTMAP_VALUE,
    }
  };
fprintf(stderr, "STRING QUERY '%s'\n", elts[ 0 ]);
  CHECK(naio_resobj_iter(o, 7, query));
fprintf(stderr, "SUCCESS\n");
  o = query[ 6 ].object;
  for (i=1; i < nelts; i++) {
    query = (naio_resobj_itelt_t[]){
      {
        .flags = (NAIO_RESOBJ_FLAG_SLOT),
        .query.slot = SLOTMAP_VALUE,
      },
      {
        .flags = (NAIO_RESOBJ_FLAG_SLOT),
        .query.slot = SLOTMAP_HASH,
      },
      {
        .flags = (NAIO_RESOBJ_FLAG_SLOT),
        .query.slot = SLOTMAP_HASHELTS,
      },
      {
        .flags = (NAIO_RESOBJ_FLAG_SLOT),
        .query.slot = SLOTMAP_HASHELT,
      },
      {
        .flags = (NAIO_RESOBJ_FLAG_SLOT),
        .query.slot = SLOTMAP_STRING,
      },
      {
        .flags = (NAIO_RESOBJ_FLAG_SLOT |
                  NAIO_RESOBJ_FLAG_STRING |
                  NAIO_RESOBJ_FLAG_UPONSUCCESS),
        .query.slot = SLOTMAP_STRINGCONTENT,
        .query.string = elts[ i ],
        .uponsuccess = 2
      },
      {
        .flags = (NAIO_RESOBJ_FLAG_SLOT),
        .query.slot = SLOTMAP_VALUE,
      }
    };
fprintf(stderr, "STRING QUERY '%s'\n", elts[ i ]);
    CHECK(naio_resobj_iter(o, 7, query));
    o = query[ 5 ].object;
  }
  *result = o;
  return NAIG_OK;
}
