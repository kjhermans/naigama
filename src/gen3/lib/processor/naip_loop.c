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

#include "naip_private.h"

/**
 * Runs the scripting engine against scripting bytecode.
 */
NAIG_ERR_T naip_loop
  (naip_t* engine)
{
  naip_stent_t entry1, entry2, entry3;
  uint32_t opcode, param1; //, param2, param3;
  unsigned instrlength;

  while (1) {
    //.. check engine->bytecode_offset
    opcode = GET_32BIT_VALUE(engine->bytecode, engine->bytecode_offset);
    instrlength = engine->bytecode[ engine->bytecode_offset + 1 ];
    //.. check instruction size is inside bytecode buffer

    switch (opcode) {
    case OPCODE_SCR_ADD:
      STACK_POP(entry1);
      STACK_POP(entry2);
      CHECK(naip_add(&entry1, &entry2, &entry3));
      STACK_PUSH(entry3);
      engine->bytecode_offset += instrlength;
      break;

    case OPCODE_SCR_ASSIGN:
      break;

    case OPCODE_SCR_BITAND:
      STACK_POP(entry1);
      STACK_POP(entry2);
      CHECK(naip_bitand(&entry1, &entry2, &entry3));
      STACK_PUSH(entry3);
      engine->bytecode_offset += instrlength;
      break;

    case OPCODE_SCR_BITANDIS:
      STACK_POP(entry1);
      STACK_POP(entry2);
      CHECK(naip_bitand(&entry1, &entry2, &entry1));
      STACK_PUSH(entry1);
      engine->bytecode_offset += instrlength;
      break;

    case OPCODE_SCR_BITNOT:
      break;

    case OPCODE_SCR_BITNOTIS:
      break;

    case OPCODE_SCR_BITOR:
      break;

    case OPCODE_SCR_BITORIS:
      break;

    case OPCODE_SCR_BITXOR:
      break;

    case OPCODE_SCR_BITXORIS:
      break;

    case OPCODE_SCR_CALL:
      break;

    case OPCODE_SCR_CONDJUMP:
      break;

    case OPCODE_SCR_DEC:
      break;

    case OPCODE_SCR_DIV:
      break;

    case OPCODE_SCR_EQUALS:
      break;

    case OPCODE_SCR_GT:
      break;

    case OPCODE_SCR_GTEQ:
      break;

    case OPCODE_SCR_INC:
      break;

    case OPCODE_SCR_JUMP:
      param1 = GET_32BIT_VALUE(engine->bytecode, engine->bytecode_offset + 4);
      engine->bytecode_offset = param1;
      break;

    case OPCODE_SCR_LOGAND:
      break;

    case OPCODE_SCR_LOGNOT:
      break;

    case OPCODE_SCR_LOGOR:
      break;

    case OPCODE_SCR_LT:
      break;

    case OPCODE_SCR_LTEQ:
      break;

    case OPCODE_SCR_MUL:
      break;

    case OPCODE_SCR_NEQUALS:
      break;

    case OPCODE_SCR_POP:
      break;

    case OPCODE_SCR_POW:
      break;

    case OPCODE_SCR_PUSH:
      break;

    case OPCODE_SCR_RET:
      break;

    case OPCODE_SCR_SHIFTIN:
      break;

    case OPCODE_SCR_SHIFTINIS:
      break;

    case OPCODE_SCR_SHIFTOUT:
      break;

    case OPCODE_SCR_SHIFTOUTIS:
      break;

    case OPCODE_SCR_SUB:
      break;

    }
  }

SYSTEMERROR: ;
  return NAIP_ERR_SYSTEM;
}
