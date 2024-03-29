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

#include <stdio.h>

#include "naie_private.h"

/**
 * Writes the engine output to a file
 * (input to the action processor).
 */
NAIG_ERR_T naie_output
  (naie_result_t* result, FILE* output)
{
  unsigned i;
  uint32_t record[ 4 ] = { SET_32BIT_VALUE(result->code), SET_32BIT_VALUE(result->count), 0, 0 };

  if (fwrite(record, sizeof(uint32_t), 4, output) != 4) {
    RETURNERR(NAIG_ERR_WRITE);
  }
  for (i=0; i < result->count; i++) {
    record[ 0 ] = SET_32BIT_VALUE(result->actions[ i ].action);
    record[ 1 ] = SET_32BIT_VALUE(result->actions[ i ].slot);
    record[ 2 ] = SET_32BIT_VALUE(result->actions[ i ].start);
    record[ 3 ] = SET_32BIT_VALUE(result->actions[ i ].length);
    if (fwrite(record, sizeof(uint32_t), 4, output) != 4) {
      RETURNERR(NAIG_ERR_WRITE);
    }
  }
  return NAIG_OK;
}
