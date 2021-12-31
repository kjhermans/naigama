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
NAIG_ERR_T naic_compile_alts
  (naic_t* naic, naio_resobj_t* alts)
{
  char success[ 64 ], alt[ 64 ];
  naio_resobj_t* expr;

  snprintf(success, sizeof(success), "__SUCCESS_%u", ++(naic->labelcount));
  expr = alts;
  while ((expr = naio_result_object_query(expr, 1, SLOT_EXPRESSION, 0)) != NULL)
  {
    if (expr->children[ 0 ]->type == SLOT_ALTERNATIVES) {
      expr = expr->children[ 0 ];
      snprintf(alt, sizeof(alt), "__ALT_%u", ++(naic->labelcount));
      NAIC_WRITE("  catch %s\n", alt);
      CHECK(naic_compile_terms(naic, expr->children[ 0 ]));
      NAIC_WRITE("  commit %s\n", success);
      NAIC_WRITE("%s:\n", alt);
    } else if (expr->children[ 0 ]->type == SLOT_TERMS) {
      CHECK(naic_compile_terms(naic, expr->children[ 0 ]));
      NAIC_WRITE("%s:\n", success);
    } else {
      abort();
    }
  }

  return NAIG_OK;
}
