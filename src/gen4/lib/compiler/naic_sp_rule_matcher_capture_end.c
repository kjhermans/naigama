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

static
NAIG_ERR_T naic_sp_rule_matcher_capture_recycle
  (
    naic_t* naic,
    naic_nsp_t* nsp,
    naic_rule_t* rule,
    naig_resobj_t* obj,
    unsigned slot
  )
{
  char* reference = obj->string;
  (void)naic;
  (void)nsp;

  naic_instrlist_push(
    &(rule->instructions),
    (naic_instr_t){
      .instr = OPCODE_ISOLATE,
      .params.ints[ 0 ] = slot
    }
  );
  naic_instrlist_push(
    &(rule->instructions),
    (naic_instr_t){
      .instr = OPCODE_CALL,
      .label = strdup(reference)
    }
  );
  naic_instrlist_push(
    &(rule->instructions),
    (naic_instr_t){
      .instr = OPCODE_ENDISOLATE,
      .params.ints[ 0 ] = slot
    }
  );

  return NAIG_OK;
}

static
NAIG_ERR_T naic_sp_rule_matcher_capture_replace
  (
    naic_t* naic,
    naic_nsp_t* nsp,
    naic_rule_t* rule,
    naig_resobj_t* obj,
    unsigned slot
  )
{
  char label[ 64 ];

  snprintf(label, sizeof(label), "__L%u", ++(naic->labelcount));
  naic_instrlist_push(
    &(rule->instructions),
    (naic_instr_t){
      .instr = OPCODE_REPLACE,
      .params.ints[ 0 ] = slot,
      .label = strdup(label)
    }
  );
  NAIG_CHECK(naic_sp_rule_replace(naic, nsp, rule, obj), PROPAGATE);
  naic_instrlist_push(
    &(rule->instructions),
    (naic_instr_t){
      .instr = OPCODE_ENDREPLACE,
      .params.ints[ 0 ] = slot
    }
  );
  naic_instrlist_push(
    &(rule->instructions),
    (naic_instr_t){
      .instr = OPCODE_LABEL,
      .label = strdup(label)
    }
  );

  return NAIG_OK;
}

/**
 * Compiler second pass function
 *
 * \param naic  Initialized compiler structure.
 * \param nsp   The current rule.
 * \param rule  The current rule.
 * \param obj   Parse node to be used by this function.
 * \param slot
 * \returns     NAIG_OK on success, or a NAIG_ERR_* value on error.
 */
NAIG_ERR_T naic_sp_rule_matcher_capture_end
  (
    naic_t* naic,
    naic_nsp_t* nsp,
    naic_rule_t* rule,
    naig_resobj_t* obj,
    unsigned slot
  )
{
  DEBUGFUNCTION;
  ASSERT(naic != NULL);
  ASSERT(nsp != NULL);
  ASSERT(rule != NULL);
  ASSERT(obj != NULL);

  naig_resobj_t* recycle;
  naig_resobj_t* replace;

  recycle = naig_result_object_query(
    obj, 3,
    SLOTMAP_CAPTUREEND_, 0,
    SLOTMAP_RECYCLE_, 0,
    SLOTMAP_IDENT_
  );
  replace = naig_result_object_query(
    obj, 3,
    SLOTMAP_CAPTUREEND_, 0,
    SLOTMAP_REPLACE_, 0,
    SLOTMAP_REPLACETERMS_
  );

  if (recycle) {
    NAIG_CHECK(
      naic_sp_rule_matcher_capture_recycle(naic, nsp, rule, recycle, slot),
      PROPAGATE
    );
  } else if (replace) {
    NAIG_CHECK(
      naic_sp_rule_matcher_capture_replace(naic, nsp, rule, replace, slot),
      PROPAGATE
    );
  }

  return NAIG_OK;
}
