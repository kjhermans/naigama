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
NAIG_ERR_T naic_fp_funcparams
  (naic_t* naic, naio_resobj_t* params, naic_nspnod_t* func)
{
  unsigned i;
  char* paramname;
  naic_nspnod_t* parament;
  (void)naic;

  ASSERT(naic != NULL);
  ASSERT(params != NULL);
  ASSERT(func != NULL);
  ASSERT(func->type == NAIC_NSPTYPE_FUNCTION);

naic_resobj_debug(params);

  for (i=0; i < params->nchildren; i++) {

    ASSERT(params->children[ i ] != NULL)
    ASSERT(params->children[ i ]->children[ 0 ] != NULL)

    paramname = params->children[ i ]->children[ 0 ]->string;
    ++(func->value.function.params.count);
    func->value.function.params.list =
      (naic_param_t*)
      realloc(
        func->value.function.params.list,
        func->value.function.params.count * sizeof(naic_param_t)
      );
    func->value.function.params.list[
      func->value.function.params.count
    ].name = paramname;
    CHECK(
      naic_nsp_add_var(
        func,
        paramname,
        NULL,
        params->children[ i ],
        &parament
      )
    );
  }
  DBGLOG(
    "Function %s has %u parameters.\n"
    , func->name
    , func->value.function.params.count
  );
  return NAIG_OK;
}
