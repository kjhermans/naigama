/**
 * This file is part of Oroszlan, a parsing and scripting environment

Copyright (c) 2021, Kees-Jan Hermans <kees.jan.hermans@gmail.com>
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

#include "../naic_private.h"

/**
 *
 */
NAIG_ERR_T naic_fp_rule_tree
  (naic_t* naic, naio_resobj_t* rule, naio_resobj_t* top)
{
  unsigned i;
  char* name;
  naio_resobj_t* ident;
  naio_resobj_t* child;

  ASSERT(naic != NULL)
  ASSERT(rule != NULL)
  ASSERT(top != NULL)
  
  for (i=0; i < top->nchildren; i++) {
    child = top->children[ i ];
    if (child->type == SLOT_CAPTURE) {
      CHECK(naio_slotmap_add_capture(naic->slotmap, rule, child, naic->slot));
      child->aux.num = (naic->slot)++;

//      CHECK(naic_fp_capture_push(naic, naic->slot));
      CHECK(naic_fp_rule_tree(naic, rule, child));
//      CHECK(naic_fp_capture_pop(naic));

    } else if (child->type == SLOT_VARCAPTURE) {
      ident = naio_result_object_query(
        child, 1, SLOT_IDENT, 0
      );
      ASSERT(ident != NULL)
      name = ident->string;
      CHECK(naic_nsp_add_rulevar(naic->currentscope, name, naic->slot));
      CHECK(naio_slotmap_add_capture(naic->slotmap, rule, child, naic->slot));
      child->aux.num = (naic->slot)++;

//      CHECK(naic_fp_capture_push(naic, naic->slot));
      CHECK(naic_fp_rule_tree(naic, rule, child));
//      CHECK(naic_fp_capture_pop(naic));

    } else if (child->type == SLOT_REFERENCE) {
/*
      ident = naio_result_object_query(
        child, 1, SLOT_IDENT, 0
      );
      ASSERT(ident != NULL)
      name = ident->string;
fprintf(stderr, "Rule %u has child reference '%s'\n", naic->rule.index, name);
*/
/*
      child->aux.num = naic->rule.index;
*/

    } else {
      CHECK(naic_fp_rule_tree(naic, rule, child));
    }
  }
  return NAIG_OK;
}
