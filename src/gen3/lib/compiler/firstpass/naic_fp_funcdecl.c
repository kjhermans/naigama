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

#include <string.h>

#include <naigama/engine/naie.h>
#include <naigama/naig_private.h>
#include "../naic_private.h"

/**
 *
 */
NAIG_ERR_T naic_fp_funcdecl
  (naic_t* naic, naio_resobj_t* func, naic_nspnod_t* nsp)
{
  char* funcname;
  naic_nspnod_t* nspnod;
  naio_resobj_t* ident, * params, * body;

  ASSERT(naic != NULL)
  ASSERT(func != NULL)
  ASSERT(nsp != NULL)

  ident = naio_result_object_query(
    func, 1, SLOT_IDENT, 0
  );
  funcname = ident->string;
  params = naio_result_object_query(
    func, 1, SLOT_FUNCPARAMDECL, 0
  );
  body = naio_result_object_query(
    func, 1, SLOT_FUNCBODY, 0
  );

  if (0 == strcmp("__main", funcname)) {
    if (naic->firsttype == NAIC_FIRST_MAINRULE) {
      fprintf(stderr, "ERROR: Both main rule and function found.\n");
      return NAIG_ERR_DOUBLEMAIN; 
    } else if (naic->firsttype == NAIC_FIRST_MAINFUNCTION) {
      fprintf(stderr, "ERROR: Two main functions found.\n");
      return NAIG_ERR_DOUBLEMAIN;
    } else {
      naic->firsttype = NAIC_FIRST_MAINFUNCTION;
      naic->first = funcname;
    }
  } else if (0 == naic->firsttype) {
    naic->firsttype = NAIC_FIRST_FUNCTION;
    naic->first = funcname;
  }

  CHECK(naic_nsp_add_func(nsp, funcname, func, &nspnod));
  func->auxptr = nspnod;
  CHECK(naic_fp_funcparams(naic, params, nspnod));
  CHECK(naic_fp_funcbody(naic, body, nspnod));
  return NAIG_OK;
}
