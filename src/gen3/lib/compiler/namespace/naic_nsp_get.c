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
NAIG_ERR_T naic_nsp_get
  (naic_nspnod_t* nsp, char* key, naic_nspnod_t** entry, int search)
{
  unsigned i;

  DBGLOG("nsp=%p;key=%s\n", nsp, key);
  ASSERT(nsp != NULL)
  ASSERT(key != NULL)
  ASSERT(entry != NULL)

  while (nsp) {
    for (i=0; i < nsp->children.count; i++) {
      DBGLOG("cmp '%s' with '%s'\n", key, nsp->children.list[ i ]->name);
      if (nsp->children.list[ i ]->name
          && 0 == strcmp(nsp->children.list[ i ]->name, key))
      {
        *entry = nsp->children.list[ i ];
        return NAIG_OK;
      }
      if (nsp->parent) {
        char path[ 2048 ];
        char copy[ 2048 ];
        naic_nspnod_t* parent = nsp->children.list[ i ];
        snprintf(path, sizeof(path), "%s", nsp->children.list[ i ]->name);
        snprintf(copy, sizeof(copy), "%s", path);
        while ((parent = parent->parent) != NULL && parent->name != NULL) {
          snprintf(path, sizeof(path), "%s__%s", parent->name, copy);
          snprintf(copy, sizeof(copy), "%s", path);
          DBGLOG("cmp '%s' with '%s'\n", key, path);
          if (0 == strcmp(path, key)) {
            *entry = nsp->children.list[ i ];
            return NAIG_OK;
          }
        }
      }
      if (nsp->children.list[ i ]->children.count) {
        NAIG_ERR_T e = naic_nsp_get(nsp->children.list[ i ], key, entry, search);
        if (e.code == 0) {
          return NAIG_OK;
        }
      }
    }
    if (!search) { break; }
    nsp = nsp->parent;
  }
  return NAIG_ERR_NOTFOUND;
}
