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
NAIG_ERR_T naic_compile_if
  (naic_t* naic, naio_resobj_t* f)
{
  unsigned i;
  naio_resobj_t* condition;
  naio_resobj_t* stmts;
  naio_resobj_t* if_elsif;
  naio_resobj_t* if_else;
  char nxt[ 64 ];
  naic_nspnod_t* nspnodry;

  condition = naio_resobj_query(f, 2, SLOT_CONDITION, 0, SLOT_SCR_EXPRESSION, 0);
  stmts = naio_resobj_query(f, 1, SLOT_BLOCK, 0);

  ++(naic->labelcount);
  snprintf(nxt, sizeof(nxt), "__IF_NXT_%u_1", naic->labelcount);

  /* first if, condition and statement block */
  CHECK(naic_compile_expr(naic, condition));
  NAIC_WRITE("  scr_condjump %s\n", nxt);
  nspnodry = (naic_nspnod_t*)(stmts->auxptr);
  naic->currentscope = nspnodry;
  CHECK(naic_compile_stmts(naic, stmts));
  naic->currentscope = nspnodry->parent;
  NAIC_WRITE("%s:\n", nxt);

  /* all the potential elseifs */
  i = 0;
  while ((if_elsif = naio_resobj_query(f, 1, SLOT_IF_ELSIF, i++)) != NULL) {
    condition = naio_resobj_query(if_elsif, 2, SLOT_CONDITION, 0, SLOT_SCR_EXPRESSION, 0);
    stmts = naio_resobj_query(if_elsif, 1, SLOT_BLOCK, 0);
    snprintf(nxt, sizeof(nxt), "__IF_NXT_%u_%u", naic->labelcount, i);
    CHECK(naic_compile_expr(naic, condition));
    NAIC_WRITE("  scr_condjump %s\n", nxt);
    nspnodry = (naic_nspnod_t*)(stmts->auxptr);
    naic->currentscope = nspnodry;
    CHECK(naic_compile_stmts(naic, stmts));
    naic->currentscope = nspnodry->parent;
    NAIC_WRITE("%s:\n", nxt);
  }

  /* the potential final else */
  if ((if_else = naio_resobj_query(f, 1, SLOT_IF_ELSE, 0)) != NULL) {
    stmts = naio_resobj_query(if_else, 1, SLOT_BLOCK, 0);
    nspnodry = (naic_nspnod_t*)(stmts->auxptr);
    naic->currentscope = nspnodry;
    CHECK(naic_compile_stmts(naic, stmts));
    naic->currentscope = nspnodry->parent;
  }
  return NAIG_OK;
}
