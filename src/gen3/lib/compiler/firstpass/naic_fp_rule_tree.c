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

  ASSERT(naic != NULL)
  ASSERT(rule != NULL)
  ASSERT(top != NULL)
  
  for (i=0; i < top->nchildren; i++) {
    if (top->children[ i ]->type == SLOT_CAPTURE) {
      CHECK(naio_slotmap_add_capture(naic->slotmap, rule, top->children[ i ], naic->slot));
      top->children[ i ]->aux.num = (naic->slot)++;
      CHECK(naic_fp_rule_tree(naic, rule, top->children[ i ]));
    } else if (top->children[ i ]->type == SLOT_VARCAPTURE) {
      ident = naio_result_object_query(
        top->children[ i ], 1, SLOT_IDENT, 0
      );
      ASSERT(ident != NULL)
      name = ident->string;
      CHECK(naic_nsp_add_rulevar(naic->currentscope, name, naic->slot));
      CHECK(naio_slotmap_add_capture(naic->slotmap, rule, top->children[ i ], naic->slot));
      top->children[ i ]->aux.num = (naic->slot)++;
      CHECK(naic_fp_rule_tree(naic, rule, top->children[ i ]));
    } else {
      CHECK(naic_fp_rule_tree(naic, rule, top->children[ i ]));
    }
  }
  return NAIG_OK;
}
