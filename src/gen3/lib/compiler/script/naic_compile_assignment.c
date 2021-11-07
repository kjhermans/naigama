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
NAIG_ERR_T naic_compile_assignment
  (naic_t* naic, naio_resobj_t* assignment)
{
  naic_nspnod_t* entry;
  naio_resobj_t* reference;
  naio_resobj_t* expression;

  ASSERT(naic != NULL)
  ASSERT(assignment != NULL)
  ASSERT(assignment->type == SLOT_ASSIGNMENT)

  reference = naio_resobj_query(assignment, 1, SLOT_SCR_REFERENCE, 0);
  expression = naio_resobj_query(assignment, 1, SLOT_SCR_EXPRESSION, 0);

  ASSERT(reference != NULL)
  ASSERT(expression != NULL)

  CHECK(naic_compile_scr_reference(naic, reference));
  CHECK(naic_compile_expr(naic, expression));
  NAIC_WRITE("  scr_assign\n"); 
  return NAIG_OK;
}
