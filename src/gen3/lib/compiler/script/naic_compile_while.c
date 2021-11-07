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
NAIG_ERR_T naic_compile_while
  (naic_t* naic, naio_resobj_t* whl)
{
  naio_resobj_t* condition = whl->children[ 0 ];
  naio_resobj_t* stmts = whl->children[ 1 ];
  char top[ 64 ], out[ 64 ];
  naic_nspnod_t* nspnodry;
  unsigned scopelabel;

  scopelabel = ++(naic->labelcount);
  snprintf(top, sizeof(top), "__WHILE_TOP_%u", naic->labelcount);
  snprintf(out, sizeof(out), "__WHILE_OUT_%u", naic->labelcount);
  NAIC_WRITE(
    "%s:\n"
    , top
  );
  CHECK(naic_compile_expr(naic, condition));
  NAIC_WRITE(
    "  scr_condjump %s\n"
    , out
  );
  nspnodry = (naic_nspnod_t*)(stmts->auxptr);
  naic->currentscope = nspnodry;
  naic->currentscope->scopelabel = scopelabel;
  CHECK(naic_compile_stmts(naic, stmts));
  naic->currentscope = nspnodry->parent;
  NAIC_WRITE(
    "  jump %s\n"
    "%s:\n"
    , top
    , out
  );
  return NAIG_OK;
}
