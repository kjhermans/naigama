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

#include "naia_private.h"

/**
 *
 */
NAIG_ERR_T naia_process_scr_push
  (naia_t* naia, naio_resobj_t* object)
{
  uint32_t instruction[ 4 ];
  int32_t tmp;
  uint32_t offset;
  double f;
  void* mem = &(instruction[ 2 ]);

  instruction[ 0 ] = SET_32BIT_VALUE(OPCODE_SCR_PUSH);
  switch (object->children[ 1 ]->type) {
  case ASMSLOT_STRINGREF_STRINGSLABEL:
    instruction[ 1 ] = SET_32BIT_VALUE(NAIE_SCALAR_TYPE_STRING);
    CHECK(
      naio_labelmap_get(
        &(naia->labels),
        object->children[ 1 ]->string,
        object->children[ 1 ]->stringlen,
        &offset
      )
    );
    SET_32BIT_NWO(&(instruction[ 2 ]), 0, offset);
    break;
  case ASMSLOT_REGISTERREF_NUMBER:
    instruction[ 1 ] = SET_32BIT_VALUE(NAIE_SCALAR_TYPE_REFERENCE);
    tmp = atoi(object->children[ 1 ]->string);
    SET_32BIT_NWO(&(instruction[ 2 ]), 0, tmp);
    break;
  case ASMSLOT_FLOATLITERAL:
    instruction[ 1 ] = SET_32BIT_VALUE(NAIE_SCALAR_TYPE_FLOAT);
    f = atof(object->children[ 1 ]->string);
    memcpy(mem, &f, sizeof(double));
    break;
  case ASMSLOT_INTLITERAL:
    instruction[ 1 ] = SET_32BIT_VALUE(NAIE_SCALAR_TYPE_INT);
    tmp = atoi(object->children[ 1 ]->string);
    SET_32BIT_NWO(&(instruction[ 2 ]), 0, tmp);
    break;
  case ASMSLOT_BOOLEANLITERAL_TRUEFALSE:
    break;
  case ASMSLOT_VOIDLITERAL_VOID:
    instruction[ 1 ] = SET_32BIT_VALUE(NAIE_SCALAR_TYPE_VOID);
    break;
  default:
fprintf(stderr, "PUSH FOUND TYPE %u\n", object->children[ 1 ]->type);
  }
  CHECK(naia->write(&instruction, sizeof(instruction), naia->write_arg));
  return NAIG_OK;
}
