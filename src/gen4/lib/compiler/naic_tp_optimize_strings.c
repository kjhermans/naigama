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

#include <naigama/naigama/naig_instructions.h>

#include "naic_private.h"

static
int naic_tp_instr_examine_string
  (naic_instrlist_t* list, unsigned i, naic_instr_t* instr, void* ptr)
{
  unsigned* charcount = ptr;
  (void)list;
  (void)i;

  if (instr->instr == OPCODE_CHAR) {
    if (++(*charcount) == 4) {
      if (i >= 3) {
        uint8_t c0 = naic_instrlist_getptr(list, i-3)->params.ints[ 0 ];
        uint8_t c1 = naic_instrlist_getptr(list, i-2)->params.ints[ 0 ];
        uint8_t c2 = naic_instrlist_getptr(list, i-1)->params.ints[ 0 ];
        uint8_t c3 = naic_instrlist_getptr(list, i-0)->params.ints[ 0 ];
        instr->instr = OPCODE_QUAD;
        instr->params.ints[ 0 ] = (c0 << 24) | (c1 << 16) | (c2 << 8) | c3;
        naic_instrlist_getptr(list, i-3)->instr = OPCODE_NONE;
        naic_instrlist_getptr(list, i-2)->instr = OPCODE_NONE;
        naic_instrlist_getptr(list, i-1)->instr = OPCODE_NONE;
      }
      *charcount = 0;
    }
  } else {
    *charcount = 0;
  }
  return 0;
}

static
int naic_tp_rule_optimize_strings
  (naic_rulelist_t* list, unsigned i, naic_rule_t* rule, void* ptr)
{
  (void)i;
  (void)list;
  (void)ptr;
  unsigned charcount = 0;

  return naic_instrlist_iterate(
    &(rule->instructions),
    naic_tp_instr_examine_string,
    &charcount
  );
}

static
int naic_tp_nsp_optimize_strings
  (naic_t* naic, naic_nsp_t* nsp)
{
  (void)naic;
  int e;
  unsigned charcount = 0;

  e = naic_instrlist_iterate(
    &(nsp->instructions),
    naic_tp_instr_examine_string,
    &charcount
  );
  if (e) { return e; }
  e = naic_rulelist_iterate(
    &(nsp->rules),
    naic_tp_rule_optimize_strings,
    0
  );

  return e;
}

/**
 *
 */
NAIG_ERR_T naic_tp_optimize_strings
  (naic_t* naic)
{
  naic_nsp_t* nsp = &(naic->namespace.top);
  int e;

  if ((e = naic_tp_nsp_optimize_strings(naic, nsp)) != 0) {
    RETURNERR(NAIG_ERR_REFERENCE);
  }

  return NAIG_OK;
}
