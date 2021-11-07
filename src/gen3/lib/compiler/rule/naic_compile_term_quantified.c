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
NAIG_ERR_T naic_compile_term_quantified
  (naic_t* naic, naio_resobj_t* term)
{
  int range[ 2 ];
  unsigned i;
  naio_resobj_t* quantifier = NULL;

  ASSERT(term->type == SLOT_QUANTIFIEDMATCHER)

  for (i=0; i < term->nchildren; i++) {
    if (term->children[ i ]->type == SLOT_QUANTIFIER) {
      quantifier = term->children[ i ];
      break;
    }
  }

  if (quantifier == NULL) {
    CHECK(naic_compile_matcher(naic, term->children[ 0 ]));
  } else {
    CHECK(
      naic_compile_get_quantifiers(
        naic,
        quantifier,
        range
      )
    );
    if (range[ 0 ] == 1 && range[ 1 ] == 1) {
      CHECK(naic_compile_matcher(naic, term->children[ 0 ]));
    } else {
      if (naic->flags & (NAIC_FLG_LOOPS|NAIC_FLG_TRADITIONAL)) {
        CHECK(
          naic_compile_quantified_matcher_trad(
            naic,
            term->children[ 0 ],
            range
          )
        );
      } else {
        CHECK(
          naic_compile_quantified_matcher(
            naic,
            term->children[ 0 ],
            range
          )
        );
      }
    }
  }
  return NAIG_OK;
}
