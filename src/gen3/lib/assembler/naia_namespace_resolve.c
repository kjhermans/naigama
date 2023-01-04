/**
 * This file is part of Oroszlan, a parsing and scripting environment

Copyright (c) 2023, Kees-Jan Hermans <kees.jan.hermans@gmail.com>
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

#include "naia_private.h"

static
NAIG_ERR_T naia_namespace_resolve_
  (naia_namespace_t* namespace, char* name, unsigned len, unsigned* offset)
{
  char path[ 4096 ];
  char copy[ 4096 ];
  naia_namespace_t* nsp = namespace;

  snprintf(path, sizeof(path), "%-.*s", len, name);
  while (nsp) {
    NAIG_ERR_T e = naio_labelmap_get(&(nsp->labels), path, strlen(path), offset);
    switch (e.code) {
    case 0:
      return NAIG_OK;
    case NAIG_ERRCODE_LABEL:
      break;
    default:
      return e;
    }
    snprintf(copy, sizeof(copy), "%s", path);
    snprintf(path, sizeof(path), "%s__%s", nsp->name, copy);
    nsp = nsp->parent;
  }
  for (unsigned i=0; i < namespace->nchildren; i++) {
    NAIG_ERR_T e = naia_namespace_resolve_(namespace->children[ i ], name, len, offset);
    if (e.code == 0) {
      return NAIG_OK;
    }
  }
  return NAIG_ERR_NOTFOUND;
}

/**
 *
 */
NAIG_ERR_T naia_namespace_resolve
  (naia_t* naia, char* name, unsigned len, unsigned* offset)
{
  naia_namespace_t* namespace = naia->namespace.current;
  NAIG_ERR_T e = naia_namespace_resolve_(namespace, name, len, offset);

  switch (e.code) {
  case 0:
    return NAIG_OK;
  case NAIG_ERRCODE_NOTFOUND:
  case NAIG_ERRCODE_LABEL:
    snprintf(naia->error, sizeof(naia->error), "Label '%-.*s' not found.", len, name);
    __attribute__((fallthrough));
  default:
    return e;
  }
}
