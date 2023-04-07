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
#include <naigama/parser/naip.h>
//#include <naigama/naigama/naig_functions.h>

/**
 * First pass compiler topmost function.
 *
 * \param naic  Initialized compiler structure.
 * \param top   Parse node of the top of the parse tree.
 * \param nsp   Namespace currently in.
 * \param allowsingle Whether or not single expressions are allowed
 *                    (only allowed in the topmost namespace).
 * \returns     NAIG_OK on success, or a NAIG_ERR_* value on error.
 */
NAIG_ERR_T naic_fp
  (naic_t* naic, naig_resobj_t* top, naic_nsp_t* nsp, int allowsingle)
{
  unsigned i = 0;
  naig_resobj_t* def;

  DEBUGFUNCTION;
  ASSERT(naic != NULL);
  ASSERT(top != NULL);

  if ((def = naig_result_object_query(
               top, 2, SLOTMAP_GRAMMAR_, 0,
                       SLOTMAP_SINGLE_EXPRESSION_, 0,
                       SLOTMAP_EXPRESSION_, 0))
               != NULL)
  {
    if (allowsingle) {
      naic->flags |= NAIC_FLG_SINGLE_EXPRESSION;
      NAIG_CHECK(naic_fp_rule_single(naic, def, nsp), PROPAGATE);
      return NAIG_OK;
    }
    RETURNERR(NAIG_ERR_SINGLE);
  } else {
    while ((def = naig_result_object_query(
                    top, 2, SLOTMAP_GRAMMAR_, 0, SLOTMAP_DEFINITION_, i++))
                    != NULL)
    {
      switch (def->children[ 0 ]->type) {
      case SLOTMAP_RULE_:
        NAIG_CHECK(naic_fp_rule(naic, def->children[ 0 ], nsp), PROPAGATE);
        break;
      case SLOTMAP_IMPORTDECL_:
        NAIG_CHECK(naic_fp_import(naic, def->children[ 0 ], nsp), PROPAGATE);
        break;
      default:
TODO("Implement default case");
      }
    }
  }
  return NAIG_OK;
}
