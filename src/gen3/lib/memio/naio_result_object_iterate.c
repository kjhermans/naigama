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

#include "naio_private.h"

static
int naio_result_object_iterate_
  (
    naio_resobj_t* resobj,
    unsigned nthchild,
    unsigned nelts,
    naio_resobj_itelt_t* elts
  )
{
  int reqsux = 0;
  int sux = 0;
  unsigned relindex = 0;
  unsigned i;

fprintf(stderr, "--- %s\n", __FILE__);
  if (nelts == 0) {
    return ~0;
  }
//fprintf(stderr, "Node '%s'\n", resobj->string);
  if (elts[ 0 ].flags & NAIO_RESOBJ_FLAG_SLOT) {
fprintf(stderr, "Require slot %u got %u\n", elts[ 0 ].query.slot, resobj->type);
    ++reqsux;
    if (resobj->type == elts[ 0 ].query.slot) {
      ++sux;
    }
  }
  if (elts[ 0 ].flags & NAIO_RESOBJ_FLAG_STRING) {
    ++reqsux;
    if (0 == strcmp(resobj->string, elts[ 0 ].query.string)) {
      ++sux;
    }
  }
  if (elts[ 0 ].flags & NAIO_RESOBJ_FLAG_MEM) {
    ++reqsux;
    if (elts[ 0 ].query.mem.size == resobj->stringlen
        && 0 == memcmp(
                  resobj->string,
                  elts[ 0 ].query.string,
                  resobj->stringlen))
    {
      ++sux;
    }
  }
fprintf(stderr, "Require %u, got %u\n", reqsux, sux);
  if (sux == reqsux) {

    if (elts[ 0 ].flags & NAIO_RESOBJ_FLAG_ABSINDEX) {
      if (elts[ 0 ].query.absindex != nthchild) {
        return ~0;
      }
    } else if (elts[ 0 ].flags & NAIO_RESOBJ_FLAG_RELINDEX) {
      if (elts[ 0 ].query.relindex != relindex) {
        return ~0;
      }
    }
    ++relindex;

    if (elts[ 0 ].flags & NAIO_RESOBJ_FLAG_UPONSUCCESS) {
fprintf(stderr, "MOVING UP %u\n", elts[ 0 ].uponsuccess);
      for (i=0; i < elts[ 0 ].uponsuccess; i++) {
        if ((resobj = resobj->parent) == NULL) {
          return ~0;
        }
      }
    }

    elts[ 0 ].object = resobj;
fprintf(stderr, "AT THE END, NELTS=%u\n", nelts);
    if (nelts == 1) {
fprintf(stderr, "----- %s SUCCESS\n", __FILE__);
      return 0;
    } else {
      for (i=0; i < resobj->nchildren; i++) {
        if (
          naio_result_object_iterate_(
            resobj->children[ i ],
            i,
            nelts-1,
            &(elts[ 1 ])
          ) == 0)
        {
          return 0;
        }
      }
    }
  }
  return ~0;
}

/**
 *
 */
NAIG_ERR_T naio_result_object_iterate
  (naio_resobj_t* resobj, unsigned nelts, naio_resobj_itelt_t* elts)
{
  if (naio_result_object_iterate_(resobj, 0, nelts, elts) == 0) {
    return NAIG_OK;
  } else {
    return NAIG_ERR_NOTFOUND;
  }
}
