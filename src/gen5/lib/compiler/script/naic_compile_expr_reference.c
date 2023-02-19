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
NAIG_ERR_T naic_compile_expr_reference
  (naic_t* naic, naio_resobj_t* ref)
{
  unsigned i;
  char* name;
  naic_nspnod_t* entry;
  NAIG_ERR_T e;

  ASSERT(naic != NULL)
  ASSERT(ref != NULL)

  for (i=0; i < ref->nchildren; i++) {
    if (ref->children[ i ]->type == SLOT_IDENT) {
      name = ref->children[ i ]->children[ 0 ]->string;
      if (!NAIG_ISOK(e = naic_nsp_get(naic->currentscope, name, &entry, 1))) {
        if (e.code == NAIGE_NOTFOUND) {
          snprintf(naic->error, sizeof(naic->error),
            "Reference to '%s' not found.", name
          );
          return NAIG_ERR_NOTFOUND;
        }
        return e;
      }
      if (entry->type != NAIC_NSPTYPE_CODEVAR
          && entry->type != NAIC_NSPTYPE_CODEGLOBAL)
      {
        snprintf(naic->error, sizeof(naic->error),
          "Reference to '%s'; not a variable.", name
        );
        return NAIG_ERR_NOTFOUND;
      }
      NAIC_WRITE("  scr_push { %d }\n", entry->value.codevar.reg);
    }
  }
  return NAIG_OK;
}
