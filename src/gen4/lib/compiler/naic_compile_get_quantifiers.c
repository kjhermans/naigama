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

#include "naic_private.h"

/**
 *
 */
NAIG_ERR_T naic_compile_get_quantifiers
  (naic_t* naic, naig_resobj_t* quant, int range[ 2 ])
{
  DEBUGFUNCTION;
  ASSERT(naic);
  ASSERT(quant);
  ASSERT(quant->type == SLOTMAP_QUANTIFIER_);
  ASSERT(quant->nchildren);
  ASSERT(range);

  (void)naic;

  quant = quant->children[ 0 ];

  switch (quant->type) {
  case SLOTMAP_Q_ZEROORONE_:
    range[ 0 ] = 0;
    range[ 1 ] = 1;
    break;
  case SLOTMAP_Q_ONEORMORE_:
    range[ 0 ] = 1;
    range[ 1 ] = -1;
    break;
  case SLOTMAP_Q_ZEROORMORE_:
    range[ 0 ] = 0;
    range[ 1 ] = -1;
    break;
  case SLOTMAP_Q_FROMTO_:
    range[ 0 ] = atoi(quant->children[ 0 ]->string);
    range[ 1 ] = atoi(quant->children[ 1 ]->string);
    if (range[ 0 ] > range[ 1 ]) {
      return NAIG_ERR_QUANTIFIER;
    }
    break;
  case SLOTMAP_Q_UNTIL_:
    range[ 0 ] = 0;
    range[ 1 ] = atoi(quant->children[ 0 ]->string);
    break;
  case SLOTMAP_Q_FROM_:
    range[ 0 ] = atoi(quant->children[ 0 ]->string);
    range[ 1 ] = -1;
    break;
  case SLOTMAP_Q_SPECIFIC_:
    range[ 0 ] = atoi(quant->children[ 0 ]->string);
    range[ 1 ] = range[ 0 ];
    break;
/*
  case SLOTMAP_Q_VAR_:
    {
      char* name;
      unsigned slot;

      name = quant->children[ 0 ]->string;
      NAIG_CHECK(naic_nsp_rule_var_get(naic->currentscope, name, &slot));
      range[ 0 ] = -slot;
      range[ 1 ] = 0;
    }
    break;
*/
/*
  case SLOTMAP_VARREFERENCE_NUMBER_:
    slot = atoi(quant->children[ 0 ]->string);
    range[ 0 ] = -slot;
    range[ 1 ] = 0;
    break;
*/
  default:
    DEBUGMSG("Parsing tree structure error; %u", quant->type);
    abort();
  }
  if (range[ 0 ] == 0 && range[ 1 ] == 0) {
    return NAIG_ERR_QUANTIFIER;
  }
  return NAIG_OK;
}
