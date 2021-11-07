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
#include <naigama/builtins.h>

static char* builtins[] = NAIG_BUILTIN_STRING;

/**
 *
 */
NAIG_ERR_T naic_compile_expr_call
  (naic_t* naic, naio_resobj_t* stmt)
{
  unsigned i;
  char* name = stmt->children[ 0 ]->string;
  naic_nspnod_t* nspnodry;
  unsigned argsgiven = stmt->nchildren - 1;
  char ret[ 64 ];

  ++(naic->labelcount);
  snprintf(ret, sizeof(ret), "__RETURN_%u", naic->labelcount);
  NAIC_WRITE("  scr_push void -- Return value\n");
  NAIC_WRITE("-- arguments\n");
  for (i=1; i < stmt->nchildren; i++) {
    CHECK(naic_compile_expr(naic, stmt->children[ i ]));
  }
  NAIC_WRITE("-- /arguments\n");
  for (i=0; i < NAIG_BUILTIN_STRINGS; i++) {
    if (0 == strcmp(builtins[ i ], name)) {
      NAIC_WRITE("  scr_builtin %u\n", i+1);
      return NAIG_OK;
    }
  }
  {
    CHECK(naic_nsp_get(naic->globalscope, name, &nspnodry, 0));
    if (nspnodry->type != NAIC_NSPTYPE_FUNCTION) {
      snprintf(naic->error, sizeof(naic->error), "%s is not a function", name);
      return NAIG_ERR_CALL;
    }
    if (nspnodry->value.function.params.count > argsgiven) {
      for (i=0; i < nspnodry->value.function.params.count - argsgiven; i++) {
        NAIC_WRITE("  scr_push void -- Filler arg\n");
      }
    }
NAIC_WRITE("-- REMANING ARG POP: %u - %u = %u\n", argsgiven, nspnodry->value.function.params.count, argsgiven - nspnodry->value.function.params.count);
    if (nspnodry->value.function.params.count < argsgiven) {
      for (i=0; i < argsgiven - nspnodry->value.function.params.count; i++) {
        NAIC_WRITE("  scr_pop -- pop arg %u\n", i);
      }
    }
    NAIC_WRITE("  scr_call %s\n%s:\n" , name, ret)
  }
  return NAIG_OK;
}
