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

/**
 * Compiler second pass function
 *
 * \param naic  Initialized compiler structure.
 * \param nsp   The current rule.
 * \param rule  The current rule.
 * \param obj   Parse node to be used by this function.
 * \returns     NAIG_OK on success, or a NAIG_ERR_* value on error.
 */
NAIG_ERR_T naic_sp_rule_compile
  (naic_t* naic, naic_nsp_t* nsp, naic_rule_t* rule)
{
  DEBUGFUNCTION;
  ASSERT(naic);
  ASSERT(nsp);
  ASSERT(rule);

  unsigned slot = 0;

  naic_instrlist_push(
    &(rule->instructions),
    (naic_instr_t){
      .instr = OPCODE_LABEL,
      .label = strdup(rule->name)
    }
  );

  if (naic->flags & NAIC_FLG_PREFIX) {
    naic_instrlist_push(
      &(rule->instructions),
      (naic_instr_t){
        .instr = OPCODE_CALL,
        .label = strdup("__prefix")
      }
    );
  }
  if (0 == strcmp(rule->name, "__prefix")) {
    naic->flags |= NAIC_FLG_PREFIX;
  }
  if (naic->flags & NAIC_FLG_DEFAULTCAPTURE) {
    slot = (naic->slot)++;
    NAIG_CHECK(
      naic_slotmap_push(naic, rule->name, "", slot),
      PROPAGATE
    );
    naic_instrlist_push(
      &(rule->instructions),
      (naic_instr_t){
        .instr = OPCODE_OPENCAPTURE,
        .params.ints[ 0 ] = slot,
        .label = 0
      }
    );
  }
  NAIG_CHECK(
    naic_sp_rule_alts(naic, nsp, rule, rule->parseobject->children[ 1 ]),
    PROPAGATE
  );
  if (naic->flags & NAIC_FLG_DEFAULTCAPTURE) {
    naic_instrlist_push(
      &(rule->instructions),
      (naic_instr_t){
        .instr = OPCODE_CLOSECAPTURE,
        .params.ints[ 0 ] = slot
      }
    );
  }
  naic_instrlist_push(
    &(rule->instructions),
    (naic_instr_t){
      .instr = OPCODE_RET
    }
  );

  return NAIG_OK;
}
