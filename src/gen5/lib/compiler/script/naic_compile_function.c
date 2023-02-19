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
NAIG_ERR_T naic_compile_function
  (naic_t* naic, naio_resobj_t* func)
{
  naio_buf_t buf = NAIO_BUF_INIT, * old_buf;
  naic_nspnod_t* fncnsp;
  char* funcname;
  naio_resobj_t* ident, * params, * body;

  ASSERT(naic != NULL)
  ASSERT(func != NULL)
  ASSERT(func->children[0] != NULL)

  ident = naio_resobj_query(func, 1, SLOT_IDENT, 0);
  funcname = ident->string;
  params = naio_resobj_query(func, 1, SLOT_FUNCPARAMDECL, 0);
  body = naio_resobj_query(func, 1, SLOT_FUNCBODY, 0);

  fncnsp = func->auxptr;
  ASSERT(fncnsp != NULL)

  NAIC_WRITE(
    "\n"
    "  jump __FUNC_END_%u\n"
    "__FUNC_%s:\n"
    "  mode 1\n"
    , fncnsp->value.function.index
    , funcname
  );
  old_buf = naic->current_buffer;
  naic->current_buffer = &buf;

  naic->currentscope = fncnsp;
  naic->currentfunction = fncnsp;
  CHECK(naic_compile_function_params(naic, params));
  CHECK(naic_compile_function_body(naic, body));
  naic->currentscope = fncnsp->parent;

  naic->current_buffer = old_buf;

  NAIC_WRITE(
    "  scr_shift %u\n"
    , fncnsp->value.function.params.count + 1
  );
  if (fncnsp->value.function.maxvars > fncnsp->value.function.params.count) {
    unsigned i;
    for (i=0; i < fncnsp->value.function.maxvars
                  - fncnsp->value.function.params.count; i++)
    {
      NAIC_WRITE(
        "  scr_push void -- Reservation for vardecl\n"
      );
    }
  }
  NAIC_WRITE(
    "%s"
    "__RETSECTION_%u:\n"
    "  scr_ret\n"
    "__FUNC_END_%u:\n"
    , (buf.ptr ? (char*)(buf.ptr) : "")
    , fncnsp->value.function.index
    , fncnsp->value.function.index
  );
  if (buf.ptr) { free(buf.ptr); }
  return NAIG_OK;
}
