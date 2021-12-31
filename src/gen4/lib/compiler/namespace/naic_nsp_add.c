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

#include <naigama/naig_private.h>
#include "../naic_private.h"

/**
 *
 */
NAIG_ERR_T naic_nsp_add
  (naic_nspnod_t* nsp, naic_nspnod_t* entry)
{
  unsigned i;

  ASSERT(nsp != NULL)
  ASSERT(entry != NULL)

  DBGLOG("Adding name '%s' to namespace '%s'\n", entry->name, nsp->name);
  if (entry->name != NULL) {
    for (i=0; i < nsp->children.count; i++) {
      ASSERT(nsp->children.list[ i ] != NULL)
      ASSERT(nsp->children.list[ i ]->name != NULL)
      if (0 == strcmp(nsp->children.list[ i ]->name, entry->name)) {
        return NAIG_ERR_NAMESPACE;
      }
    }
  }
  nsp->children.list =
    realloc(
      nsp->children.list,
      sizeof(naic_nspnod_t*) * (nsp->children.count + 1)
    );
  nsp->children.list[ (nsp->children.count)++ ] = entry;
  entry->parent = nsp;
  if (entry->type == NAIC_NSPTYPE_CODEVAR) {
    unsigned varcount = 0;
    while (nsp) {
      for (i=0; i < nsp->children.count; i++) {
        if (nsp->children.list[ i ]->type == NAIC_NSPTYPE_CODEVAR) {
          ++varcount;
        }
      }
      if (nsp->type == NAIC_NSPTYPE_FUNCTION) {
        entry->value.codevar.reg = varcount;
        break;
      }
      nsp = nsp->parent;
    }
  }
  return NAIG_OK;
}
