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

#include "naic_private.h"

/**
 * Import directive handler of the compiler first pass.
 *
 * \param naic  Initialized compiler structure.
 * \param obj   Parse node of the import directive.
 * \param nsp   Namespace currently in.
 * \returns     NAIG_OK on success, or a NAIG_ERR_* value on error.
 */
NAIG_ERR_T naic_fp_import
  (naic_t* naic, naig_resobj_t* obj, naic_nsp_t* nsp)
{
  DEBUGFUNCTION;
  ASSERT(naic != NULL);
  ASSERT(obj != NULL);
  ASSERT(nsp != NULL);

  char* path = obj->children[ 1 ]->children[ 0 ]->string;
  char* name = NULL;
  naic_nsp_t* child;

  if (obj->children[ 2 ]->nchildren) {
    name = obj->children[ 2 ]->children[ 1 ]->string;
  } else {
    name = path;
  }
  NAIG_CHECK(naic_nsp_add_child(nsp, &child, name), PROPAGATE);
  NAIG_CHECK(naic_nsp_parse(naic, child, path, 1), PROPAGATE);
  child->path = strdup(path);
  DEBUGMSG("Successfully imported '%s' as '%s'\n", path, name);

  return NAIG_OK;
}
