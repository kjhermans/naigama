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
DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
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

#include "naic_private.h"

/**
 *
 */
NAIG_ERR_T naic_compile_capture
  (naic_t* naic, naie_resobj_t* group)
{
  char label[ 64 ];



  NAIC_WRITE("  opencapture %u\n", *((unsigned*)(group->auxptr)));
  CHECK(naic_compile_alts(naic, group, 0));
  NAIC_WRITE("  closecapture %u\n", *((unsigned*)(group->auxptr)));
  if (group->nchildren == 2
      && group->children[ 1 ]->type == SLOT_CAPTUREEND_REPLACERECYCLE)
  {
    switch (group->children[ 1 ]->children[ 0 ]->type) {
    case SLOT_RECYCLE_IDENT:
      NAIC_WRITE("  isolate %u\n", *((unsigned*)(group->auxptr)));
      NAIC_WRITE(
        "  call %s\n",
        group->children[ 1 ]->children[ 0 ]->children[ 0 ]->string
      );
      NAIC_WRITE("  endisolate\n");
      break;
    case SLOT_REPLACE_REPLACETERMS:
      snprintf(label, sizeof(label), "__REPLACE_%u", ++(naic->labelcount));
      NAIC_WRITE("  replace %s\n", label);
      //..
      NAIC_WRITE("  endreplace\n");
      NAIC_WRITE("%s:\n", label);
      break;
    }
  }
  return NAIG_OK;
}
