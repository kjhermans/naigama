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

/**
 *
 */
NAIG_ERR_T naic_sp_rule_matcher_limitedcall
  (naic_t* naic, naic_nsp_t* nsp, naic_rule_t* rule, naig_resobj_t* obj)
{
  DEBUGFUNCTION;
  ASSERT(naic != NULL);
  ASSERT(nsp != NULL);
  ASSERT(rule != NULL);
  ASSERT(obj != NULL);
  ASSERT(obj->nchildren > 1);

  char* mode = obj->children[ 0 ]->string;
  char* variable = obj->children[ 1 ]->string;
  char* reference = obj->children[ 2 ]->string;
  unsigned slot;

  if (0 == strcmp(mode, "ruint32")) {
    if (variable[ 0 ] == '$') {
      NAIG_CHECK(
        naic_nsp_rule_var_get(nsp, rule, variable+1, &slot),
        PROPAGATE
      );
      naic_instrlist_push(
        &(rule->instructions),
        (naic_instr_t){
          .instr = OPCODE_INTRPCAPTURE,
          .params.ints[ 0 ] = 1,
          .params.ints[ 1 ] = slot
        }
      );
      naic_instrlist_push(
        &(rule->instructions),
        (naic_instr_t){
          .instr = OPCODE_CALL,
          .label = strdup(reference)
        }
      );
    } else {
      td_printf(&(naic->errorstr), "Unknown limited call var '%s'\n", variable);
      RETURNERR(NAIG_ERR_LIMITEDCALL);
    }
  } else {
    td_printf(&(naic->errorstr), "Unknown limited call mode '%s'\n", mode);
    RETURNERR(NAIG_ERR_LIMITEDCALL);
  }

  return NAIG_OK;
}
