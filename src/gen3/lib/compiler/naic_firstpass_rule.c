/**
 * This file is part of Naigama, a parser engine.

Copyright (c) 2020, Kees-Jan Hermans <kees.jan.hermans@gmail.com>
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the <organization> nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
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

static
NAIG_ERR_T naic_firstpass_rule_tree
  (naic_t* naic, naie_resobj_t* rule, naie_resobj_t* top)
{
  unsigned i;
  char* name;

  for (i=0; i < top->nchildren; i++) {
    if (top->children[ i ]->type == SLOT_MATCHER_CAPTURE) {
      top->children[ i ]->auxptr = malloc(sizeof(unsigned));
      memcpy(top->children[ i ]->auxptr, &(naic->slot), sizeof(unsigned));
      ++(naic->slot);
      CHECK(naic_firstpass_rule_tree(naic, rule, top->children[ i ]));
    } else if (top->children[ i ]->type == SLOT_MATCHER_VARCAPTURE) {
      name = top->children[ i ]->children[ 0 ]->string;
      CHECK(naic_nsp_rule_var_add(naic, name, naic->slot));
      top->children[ i ]->auxptr = malloc(sizeof(unsigned));
      memcpy(top->children[ i ]->auxptr, &(naic->slot), sizeof(unsigned));
      ++(naic->slot);
      CHECK(naic_firstpass_rule_tree(naic, rule, top->children[ i ]));
    } else {
      CHECK(naic_firstpass_rule_tree(naic, rule, top->children[ i ]));
    }
  }
  return NAIG_OK;
}

/**
 *
 */
NAIG_ERR_T naic_firstpass_rule
  (naic_t* naic, naie_resobj_t* rule)
{
  CHECK(naic_nsp_rule_def_add(naic, rule->children[0]->string));
  CHECK(naic_firstpass_rule_tree(naic, rule, rule));
  return NAIG_OK;
}
