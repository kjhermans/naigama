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
NAIG_ERR_T naic_compile_get_quantifiers
  (naic_t* naic, naio_resobj_t* quant, int range[ 2 ])
{
  char* name;
  unsigned slot;

  ASSERT(quant->type == SLOT_QUANTIFIER)
  quant = quant->children[ 0 ];

  switch (quant->type) {
  case SLOT_Q_ZEROORONE:
    range[ 0 ] = 0;
    range[ 1 ] = 1;
    break;
  case SLOT_Q_ONEORMORE:
    range[ 0 ] = 1;
    range[ 1 ] = -1;
    break;
  case SLOT_Q_ZEROORMORE:
    range[ 0 ] = 0;
    range[ 1 ] = -1;
    break;
  case SLOT_Q_FROMTO:
    range[ 0 ] = atoi(quant->children[ 0 ]->string);
    range[ 1 ] = atoi(quant->children[ 1 ]->string);
    if (range[ 0 ] > range[ 1 ]) {
      return NAIG_ERR_QUANTIFIER;
    }
    break;
  case SLOT_Q_UNTIL:
    range[ 0 ] = 0;
    range[ 1 ] = atoi(quant->children[ 0 ]->string);
    break;
  case SLOT_Q_FROM:
    range[ 0 ] = atoi(quant->children[ 0 ]->string);
    range[ 1 ] = -1;
    break;
  case SLOT_Q_SPECIFIC:
    range[ 0 ] = atoi(quant->children[ 0 ]->string);
    range[ 1 ] = range[ 0 ];
    break;
  case SLOT_Q_VAR:
    name = quant->children[ 0 ]->string;
    CHECK(naic_nsp_rule_var_get(naic->currentscope, name, &slot));
    range[ 0 ] = -slot;
    range[ 1 ] = 0;
    break;
/*
  case SLOT_VARREFERENCE_NUMBER:
    slot = atoi(quant->children[ 0 ]->string);
    range[ 0 ] = -slot;
    range[ 1 ] = 0;
    break;
*/
  default:
    DBGLOG("Parsing tree structure error; %u", quant->type);
    abort();
  }
  if (range[ 0 ] == 0 && range[ 1 ] == 0) {
    return NAIG_ERR_QUANTIFIER;
  }
  return NAIG_OK;
}
