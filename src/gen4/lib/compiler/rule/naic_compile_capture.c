/**
 * This file is part of Naigama, a parser engine.

Copyright (c) 2020, Kees-Jan Hermans <kees.jan.hermans@gmail.com>
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the <organization> nor the
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

#include "../naic_private.h"

/**
 *
 */
NAIG_ERR_T naic_compile_capture
  (naic_t* naic, naio_resobj_t* group)
{
  char label[ 64 ];
  unsigned slot;
  naio_resobj_t* recycle;
  naio_resobj_t* replace;

  ASSERT(naic != NULL)
  ASSERT(group != NULL)

  slot = group->slotnumber;
  NAIC_WRITE("  opencapture %u\n", slot);
  CHECK(naic_compile_alts(naic, group));
  NAIC_WRITE("  closecapture %u\n", slot);

  recycle = naio_resobj_query(
    group, 3,
    SLOT_CAPTUREEND, 0,
    SLOT_RECYCLE, 0,
    SLOT_IDENT, 0
  );
  replace = naio_resobj_query(
     group, 3,
     SLOT_CAPTUREEND, 0,
     SLOT_REPLACE, 0,
     SLOT_REPLACETERMS, 0
  );

  if (recycle) {
    naic_nspnod_t* nod;
    char* key = recycle->string;
    CHECK(naic_nsp_get(naic->globalscope, key, &nod, 0));
    if (nod->type == NAIC_NSPTYPE_RULE) {
      NAIC_WRITE(
        "  isolate %u\n"
        "  call %s\n"
        "  endisolate\n"
        , slot
        , key
      );
    } else if (nod->type == NAIC_NSPTYPE_FUNCTION) {
      if (nod->value.function.params.count != 1) {
        TODO("Error message here");
        return NAIG_ERR_NOTFOUND;
      }
      NAIC_WRITE(
        "  mode 1\n"
        "  scr_push void -- Return value\n"
        "  scr_push capture %u -- Capture region argument\n"
        "  scr_call %s\n"
        "  scr_pop\n"
        "  mode 0\n"
        , slot
        , key
      );
    } else {
      TODO("Error message here");
      return NAIG_ERR_NOTFOUND;
    }
  } else if (replace) {
    snprintf(label, sizeof(label), "__REPLACE_%u", ++(naic->labelcount));
    NAIC_WRITE("  replace %u %s\n", slot, label);
    CHECK(naic_compile_replace(naic, replace));
    NAIC_WRITE("  endreplace\n");
    NAIC_WRITE("%s:\n", label);
  }
  return NAIG_OK;
}
