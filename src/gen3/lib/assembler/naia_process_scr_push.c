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
DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
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
  (naia_t* naia, unsigned i)
{
  uint32_t instruction[ 5 ];
  uint32_t tmp;
  uint32_t offset;

  instruction[ 0 ] = SET_32BIT_VALUE(OPCODE_SCR_PUSH);
  switch (naia->captures->actions[ i+1 ].slot) {
  case ASMSLOT_FUNCTIONBARRIER_FUNCTION:
    instruction[ 1 ] = SET_32BIT_VALUE(NAIE_SCALAR_TYPE_STACKRETURN);
    break;
  case ASMSLOT_STRINGREF_STRING:
    instruction[ 1 ] = SET_32BIT_VALUE(NAIE_SCALAR_TYPE_STRING);
    CHECK(
      naia_label_get(
        naia,
        naia->assembly + naia->captures->actions[ i+2 ].start,
        naia->captures->actions[ i+2 ].length,
        &offset
      )
    );
    instruction[ 2 ] = SET_32BIT_VALUE(offset);
    break;
  case ASMSLOT_REGISTERREF_NUMBER:
    instruction[ 1 ] = SET_32BIT_VALUE(NAIE_SCALAR_TYPE_REGISTER);
    tmp = atoi_substr(
      naia->assembly,
      naia->captures->actions[ i+2 ].start,
      naia->captures->actions[ i+2 ].length
    );
    instruction[ 2 ] = SET_32BIT_VALUE(tmp);
    break;
  case ASMSLOT_FLOATLITERAL:
    break;
  case ASMSLOT_INTLITERAL:
    break;
  case ASMSLOT_BOOLEANLITERAL_TRUEFALSE:
    break;
  case ASMSLOT_VOIDLITERAL_VOID:
    instruction[ 1 ] = SET_32BIT_VALUE(NAIE_SCALAR_TYPE_VOID);
    break;
  default:
fprintf(stderr, "FOUND TYPE %u\n", naia->captures->actions[ i+1 ].slot);
  }
  CHECK(naia->write(&instruction, sizeof(instruction), naia->write_arg));
  return NAIG_OK;
}
