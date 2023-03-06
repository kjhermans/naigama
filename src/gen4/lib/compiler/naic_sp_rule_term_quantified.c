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
NAIG_ERR_T naic_sp_rule_term_quantified
  (naic_t* naic, naic_nsp_t* nsp, naic_rule_t* rule, naig_resobj_t* obj)
{
  DEBUGFUNCTION;
  ASSERT(naic != NULL);
  ASSERT(nsp != NULL);
  ASSERT(rule != NULL);
  ASSERT(obj != NULL);
  ASSERT(obj->nchildren);

  int range[ 2 ];
  unsigned i;
  naig_resobj_t* quantifier = NULL;

  obj = obj->children[ 0 ];
//naig_result_object_debug(obj, 0);
  for (i=0; i < obj->nchildren; i++) {
    if (obj->children[ i ]->type == SLOTMAP_QUANTIFIER_) {
      quantifier = obj->children[ i ];
      break;
    }
  }

  if (quantifier == NULL) {
    NAIG_CHECK(
      naic_sp_rule_matcher(naic, nsp, rule, obj->children[ 0 ]),
      PROPAGATE
    );
  } else {
    NAIG_CHECK(
      naic_compile_get_quantifiers(
        naic,
        quantifier,
        range
      ),
      PROPAGATE
    ); 
    if (range[ 0 ] == 1 && range[ 1 ] == 1) {
      NAIG_CHECK(naic_sp_rule_matcher(naic, nsp, rule, obj->children[ 0 ]), PROPAGATE);
    } else {
/*
      if (naic->flags & (NAIC_FLG_LOOPS|NAIC_FLG_TRADITIONAL)) {
        NAIG_CHECK(
          naic_sp_rule_term_quantified_matcher_trad(
            naic,
            obj->children[ 0 ],
            range
          ),
          PROPAGATE
        );
      } else {
*/
        NAIG_CHECK(
          naic_sp_rule_quantified_matcher(
            naic,
            nsp,
            rule,
            obj->children[ 0 ],
            range
          ),
          PROPAGATE
        );
//      }
    }
  }

  return NAIG_OK;
}
