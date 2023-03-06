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
NAIG_ERR_T naic_sp_rule_matcher
  (naic_t* naic, naic_nsp_t* nsp, naic_rule_t* rule, naig_resobj_t* obj)
{
  DEBUGFUNCTION;
  ASSERT(naic != NULL);
  ASSERT(nsp != NULL);
  ASSERT(rule != NULL);
  ASSERT(obj != NULL);
  ASSERT(obj->nchildren);

  if (obj->type == SLOTMAP_MATCHER_) {
    obj = obj->children[ 0 ];
  }

  switch (obj->type) {
  case SLOTMAP_ANY_:
    NAIG_CHECK(naic_sp_rule_matcher_any(naic, nsp, rule), PROPAGATE);
    break;
  case SLOTMAP_SET_:
    NAIG_CHECK(naic_sp_rule_matcher_set(naic, nsp, rule, obj), PROPAGATE);
    break;
  case SLOTMAP_STRING_:
    NAIG_CHECK(naic_sp_rule_matcher_string(naic, nsp, rule, obj), PROPAGATE);
    break;
  case SLOTMAP_BITMASK_:
    NAIG_CHECK(naic_sp_rule_matcher_bitmask(naic, nsp, rule, obj), PROPAGATE);
    break;
  case SLOTMAP_HEXLITERAL_:
    NAIG_CHECK(naic_sp_rule_matcher_hexliteral(naic, nsp, rule, obj), PROPAGATE);
    break;
  case SLOTMAP_VARCAPTURE_:
    NAIG_CHECK(naic_sp_rule_matcher_varcapture(naic, nsp, rule, obj), PROPAGATE);
    break;
  case SLOTMAP_CAPTURE_:
    NAIG_CHECK(naic_sp_rule_matcher_capture(naic, nsp, rule, obj), PROPAGATE);
    break;
  case SLOTMAP_GROUP_:
    NAIG_CHECK(naic_sp_rule_matcher_group(naic, nsp, rule, obj), PROPAGATE);
    break;
  case SLOTMAP_MACRO_:
    NAIG_CHECK(naic_sp_rule_matcher_macro(naic, nsp, rule, obj), PROPAGATE);
    break;
  case SLOTMAP_ENDFORCE_:
    NAIG_CHECK(naic_sp_rule_matcher_endforce(naic, nsp, rule, obj), PROPAGATE);
    break;
  case SLOTMAP_VARREFERENCE_:
    NAIG_CHECK(naic_sp_rule_matcher_varreference(naic, nsp, rule, obj), PROPAGATE);
    break;
  case SLOTMAP_REFERENCE_:
    NAIG_CHECK(naic_sp_rule_matcher_reference(naic, nsp, rule, obj), PROPAGATE);
    break;
  case SLOTMAP_LIMITEDCALL_:
    NAIG_CHECK(naic_sp_rule_matcher_limitedcall(naic, nsp, rule, obj), PROPAGATE);
    break;
  }

  return NAIG_OK;
}
