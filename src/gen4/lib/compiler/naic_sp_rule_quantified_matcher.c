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
NAIG_ERR_T naic_sp_rule_quantified_matcher
  (
    naic_t* naic,
    naic_nsp_t* nsp,
    naic_rule_t* rule,
    naig_resobj_t* obj,
    int range[2]
  )
{
  DEBUGFUNCTION;
  ASSERT(naic != NULL);
  ASSERT(nsp != NULL);
  ASSERT(rule != NULL);
  ASSERT(obj != NULL);
  ASSERT(obj->nchildren);

  int diff;
  char counterlabel[ 64 ];
  char forgivelabel[ 64 ];
  char foreverlabel[ 64 ];
  unsigned counter;

  snprintf(forgivelabel, sizeof(forgivelabel),
    "__L%u", ++(naic->labelcount));
  snprintf(foreverlabel, sizeof(foreverlabel),
    "__L%u", ++(naic->labelcount));

  if (range[ 0 ] == 1) {
    NAIG_CHECK(naic_sp_rule_matcher(naic, nsp, rule, obj), PROPAGATE);
  } else if (range[ 0 ] > 1) {
    counter = (naic->counter)++;
    snprintf(counterlabel, sizeof(counterlabel),
      "__L%u", ++(naic->labelcount));
    
    naic_instrlist_push(
      &(rule->instructions),
      (naic_instr_t){
        .instr = OPCODE_COUNTER,
        .params.ints[ 0 ] = counter,
        .params.ints[ 1 ] = range[ 0 ]
      }
    );

    naic_instrlist_push(
      &(rule->instructions),
      (naic_instr_t){
        .instr = OPCODE_LABEL,
        .label = strdup(counterlabel)
      }
    );

    NAIG_CHECK(naic_sp_rule_matcher(naic, nsp, rule, obj), PROPAGATE);

    naic_instrlist_push(
      &(rule->instructions),
      (naic_instr_t){
        .instr = OPCODE_CONDJUMP,
        .label = strdup(counterlabel),
        .params.ints[ 0 ] = counter
      }
    );
  }
  if (range[ 1 ] == -1) {
    naic_instrlist_push(
      &(rule->instructions),
      (naic_instr_t){
        .instr = OPCODE_CATCH,
        .label = strdup(forgivelabel),
      }
    );

    naic_instrlist_push(
      &(rule->instructions),
      (naic_instr_t){
        .instr = OPCODE_LABEL,
        .label = strdup(foreverlabel),
      }
    );

    NAIG_CHECK(naic_sp_rule_matcher(naic, nsp, rule, obj), PROPAGATE);

    naic_instrlist_push(
      &(rule->instructions),
      (naic_instr_t){
        .instr = OPCODE_PARTIALCOMMIT,
        .label = strdup(foreverlabel),
      }
    );

    naic_instrlist_push(
      &(rule->instructions),
      (naic_instr_t){
        .instr = OPCODE_LABEL,
        .label = strdup(forgivelabel),
      }
    );

  } else if (range[ 1 ] > range[ 0 ]) {
    diff = range[ 1 ] - range[ 0 ];
    if (diff > 1) {
      counter = (naic->counter)++;
      snprintf(counterlabel, sizeof(counterlabel),
        "__L%u", ++(naic->labelcount));

      naic_instrlist_push(
        &(rule->instructions),
        (naic_instr_t){
          .instr = OPCODE_CATCH,
          .label = strdup(forgivelabel),
        }
      );

      naic_instrlist_push(
        &(rule->instructions),
        (naic_instr_t){
          .instr = OPCODE_COUNTER,
          .params.ints[ 0 ] = counter,
          .params.ints[ 1 ] = diff
        }
      );

      naic_instrlist_push(
        &(rule->instructions),
        (naic_instr_t){
          .instr = OPCODE_LABEL,
          .label = strdup(counterlabel),
        }
      );

      NAIG_CHECK(naic_sp_rule_matcher(naic, nsp, rule, obj), PROPAGATE);

      naic_instrlist_push(
        &(rule->instructions),
        (naic_instr_t){
          .instr = OPCODE_PARTIALCOMMIT,
          .label = strdup("__NEXT__"),
        }
      );

      naic_instrlist_push(
        &(rule->instructions),
        (naic_instr_t){
          .instr = OPCODE_CONDJUMP,
          .label = strdup(counterlabel),
          .params.ints[ 0 ] = counter
        }
      );

      naic_instrlist_push(
        &(rule->instructions),
        (naic_instr_t){
          .instr = OPCODE_COMMIT,
          .label = strdup("__NEXT__"),
        }
      );

      naic_instrlist_push(
        &(rule->instructions),
        (naic_instr_t){
          .instr = OPCODE_LABEL,
          .label = strdup(forgivelabel),
        }
      );

    } else if (diff == 1) {
      naic_instrlist_push(
        &(rule->instructions),
        (naic_instr_t){
          .instr = OPCODE_CATCH,
          .label = strdup(forgivelabel),
        }
      );

      NAIG_CHECK(naic_sp_rule_matcher(naic, nsp, rule, obj), PROPAGATE);

      naic_instrlist_push(
        &(rule->instructions),
        (naic_instr_t){
          .instr = OPCODE_COMMIT,
          .label = strdup("__NEXT__"),
        }
      );

      naic_instrlist_push(
        &(rule->instructions),
        (naic_instr_t){
          .instr = OPCODE_LABEL,
          .label = strdup(forgivelabel),
        }
      );
    }
  }

  return NAIG_OK;
}
