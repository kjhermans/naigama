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

#include <naigama/parser/naip.h>
#include <naigama/naigama/naig_type_resobj.h>
#include <naigama/naigama/naig_functions.h>
#include <naigama/naigama/naig_instructions.h>

/**
 *
 */
NAIG_ERR_T naic_sp_rule_term_notand
  (naic_t* naic, naic_nsp_t* nsp, naic_rule_t* rule, naig_resobj_t* obj)
{
  DEBUGFUNCTION;
  ASSERT(naic != NULL);
  ASSERT(nsp != NULL);
  ASSERT(rule != NULL);
  ASSERT(obj != NULL);
  ASSERT(obj->nchildren);
  ASSERT(obj->children[ 0 ]->nchildren > 1);

  char not[ 64 ], and[ 64 ];

  snprintf(not, sizeof(not), "__L%u", ++(naic->labelcount));
  snprintf(and, sizeof(and), "__L%u", ++(naic->labelcount));
  naic_instrlist_push(
    &(rule->instructions),
    (naic_instr_t){
      .instr = OPCODE_CATCH,
      .label = strdup(not)
    }
  );
  NAIG_CHECK(naic_sp_rule_matcher(naic, nsp, rule, obj->children[ 0 ]->children[ 1 ]), PROPAGATE);
  switch (obj->children[ 0 ]->children[ 0 ]->type) {
  case SLOTMAP_NOT_:
    {
      naic_instrlist_push(
        &(rule->instructions),
        (naic_instr_t){
          .instr = OPCODE_FAILTWICE
        }
      );
      naic_instrlist_push(
        &(rule->instructions),
        (naic_instr_t){
          .instr = OPCODE_LABEL,
          .label = strdup(not)
        }
      );
    }
    break;
  case SLOTMAP_AND_:
    {
      naic_instrlist_push(
        &(rule->instructions),
        (naic_instr_t){
          .instr = OPCODE_BACKCOMMIT,
          .label = strdup(and)
        }
      );
      naic_instrlist_push(
        &(rule->instructions),
        (naic_instr_t){
          .instr = OPCODE_LABEL,
          .label = strdup(not)
        }
      );
      naic_instrlist_push(
        &(rule->instructions),
        (naic_instr_t){
          .instr = OPCODE_FAIL
        }
      );
      naic_instrlist_push(
        &(rule->instructions),
        (naic_instr_t){
          .instr = OPCODE_LABEL,
          .label = strdup(and)
        }
      );
    }
    break;
  default: ;
#ifdef _DEBUG
    fprintf(stderr, "Unknown type %u at %s:\n", obj->children[ 0 ]->type, __FILE__);
    abort();
#endif
  }

  return NAIG_OK;
}
