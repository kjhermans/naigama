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

#define MACRO_CHAR(__n) \
  NAIG_CHECK( \
    naic_sp_rule_matcher_set_fromuntil( \
      naic, rule, instr.params.set, __n, __n, 0 \
    ), \
    PROPAGATE \
  );

#define MACRO_RANGE(__n,__m) \
  NAIG_CHECK( \
    naic_sp_rule_matcher_set_fromuntil( \
      naic, rule, instr.params.set, __n, __m, 0 \
    ), \
    PROPAGATE \
  );

/**
 *
 */
NAIG_ERR_T naic_sp_rule_matcher_macro
  (naic_t* naic, naic_nsp_t* nsp, naic_rule_t* rule, naig_resobj_t* obj)
{
  DEBUGFUNCTION;
  ASSERT(naic != NULL);
  ASSERT(nsp != NULL);
  ASSERT(rule != NULL);
  ASSERT(obj != NULL);

  naic_instr_t instr = {
    .instr = OPCODE_SET
  };
  (void)nsp;

  memset(instr.params.set, 0, sizeof(instr.params.set));

  if (0 == strcmp(obj->string, "%s")) {
    MACRO_CHAR('\n')
    MACRO_CHAR('\r')
    MACRO_CHAR('\t')
    MACRO_CHAR('\v')
    MACRO_CHAR(' ')
  } else if (0 == strcmp(obj->string, "%w")) {
    MACRO_RANGE('A', 'Z')
    MACRO_RANGE('a', 'z')
  } else if (0 == strcmp(obj->string, "%a")) {
    MACRO_RANGE('A', 'Z')
    MACRO_RANGE('a', 'z')
    MACRO_RANGE('0', '9')
  } else if (0 == strcmp(obj->string, "%n")) {
    MACRO_RANGE('0', '9')
  } else if (0 == strcmp(obj->string, "%r")) {
    MACRO_RANGE(32, 127)
  } else {
//.. throw error
  }
  if (naic->flags & NAIC_FLG_SETSASRANGES) {
    TODO("Implement");
  } else {
    naic_instrlist_push(&(rule->instructions), instr);
  }

  return NAIG_OK;
}
