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

#include <naigama/naigama/naig_instructions.h>

static
NAIG_ERR_T naic_compile_char
  (naic_t* naic, naic_nsp_t* nsp, naic_rule_t* rule, unsigned chr, int last)
{
  DEBUGFUNCTION;
  ASSERT(naic);
  ASSERT(nsp);
  ASSERT(rule);

  (void)naic;
  (void)nsp;
  (void)last;

  naic_instrlist_push(
    &(rule->instructions),
    (naic_instr_t){
      .instr = OPCODE_CHAR,
      .params.ints[ 0 ] = chr
    }
  );

  return NAIG_OK;
}

static
NAIG_ERR_T naic_compile_char_i
  (naic_t* naic, naic_nsp_t* nsp, naic_rule_t* rule, unsigned chr, int last)
{
  DEBUGFUNCTION;
  ASSERT(naic);
  ASSERT(nsp);
  ASSERT(rule);

  naic_instr_t instr;
  (void)naic;
  (void)nsp;
  (void)last;

  memset(&instr, 0, sizeof(instr));
  instr.instr = OPCODE_SET;

  if (chr >= 'a' && chr <= 'z') {
    NAIC_SET_BIT_SET(instr.params.set, chr);
    NAIC_SET_BIT_SET(instr.params.set, chr - 32);
  } else if (chr >= 'A' && chr <= 'Z') {
    NAIC_SET_BIT_SET(instr.params.set, chr);
    NAIC_SET_BIT_SET(instr.params.set, chr + 32);
  } else {
    return naic_compile_char(naic, nsp, rule, chr, last);
  }
  naic_instrlist_push(&(rule->instructions), instr);

  return NAIG_OK;
}

/**
 *
 */
NAIG_ERR_T naic_sp_rule_matcher_string
  (naic_t* naic, naic_nsp_t* nsp, naic_rule_t* rule, naig_resobj_t* obj)
{
  DEBUGFUNCTION;
  ASSERT(naic != NULL);
  ASSERT(nsp != NULL);
  ASSERT(rule != NULL);
  ASSERT(obj != NULL);
  ASSERT(obj->nchildren);

  int caseinsensitive = 0;

  if (obj->type == SLOTMAP_STRING_) {
    if (obj->string[ strlen(obj->string)-1 ] == 'i') {
      caseinsensitive = 1;
    }
    obj = obj->children[ 0 ];
  } else if (obj->type != SLOTMAP_STRINGLITERAL_) {
    abort();
  }

  if (caseinsensitive) {
    obj = obj->children[ 0 ];
    NAIG_CHECK(
      naic_string_unescape(
        naic,
        nsp,
        rule,
        obj->string,
        naic_compile_char_i
      ),
      PROPAGATE
    );
  } else {
    obj = obj->children[ 0 ];
    NAIG_CHECK(
      naic_string_unescape(
        naic,
        nsp,
        rule,
        obj->string,
        naic_compile_char
      ),
      PROPAGATE
    );
  }

  return NAIG_OK;
}
