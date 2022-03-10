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

#include "naic_private.h"

/**
 *
 */
NAIG_ERR_T naic_sp
  (naic_t* naic, naio_resobj_t* top)
{
  naio_resobj_t* def;
  unsigned i = 0;

  if ((def = naio_result_object_query(top, 2, SLOT_GRAMMAR, 0, SLOT_SINGLE_EXPRESSION, 0)) != NULL) {
    CHECK(naic_compile_alts(naic, def->children[ 0 ]));
  } else {
    while ((def = naio_result_object_query(top, 2, SLOT_GRAMMAR, 0, SLOT_DEFINITION, i++)) != NULL) {
      switch (def->children[ 0 ]->type) {
      case SLOT_RULE:
        CHECK(naic_compile_rule(naic, def->children[ 0 ]));
        break;
      case SLOT_IMPORTDECL:
        CHECK(naic_sp(naic, def->children[ 0 ]->children[ 0 ]));
        break; 
      default:
        fprintf(stderr, "Non compliant top element\n");
        naic_resobj_debug(def->children[ 0 ]);
        abort();
      }
    }
  }
  return NAIG_OK;
}
