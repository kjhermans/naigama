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

#include "naie_private.h"

/**
 *
 */
NAIG_ERR_T naie_engine_loop_function
  (naie_engine_t* engine)
{
  naie_scalar_t scalar1, scalar2, scalar3;
  uint32_t param1; //, param2, param3;
  unsigned instruction_size;
  uint32_t opcode;

  while (1) {
    if (engine->bytecode_pos > engine->bytecode_length - 4) {
      RETURNERR(NAIE_ERR_CODEOVERFLOW);
    }
    opcode = GET_32BIT_VALUE(engine->bytecode, engine->bytecode_pos);
    instruction_size = ((opcode >> 16) & 0xff) + 4;
    if (engine->bytecode_pos + instruction_size > engine->bytecode_length) {
      if (engine->flags & NAIE_FLAG_DEBUG) {
        fprintf(stderr, "ERROR: Bytecode offset %u, instruction size %u; > %u\n"
          , engine->bytecode_pos, instruction_size, engine->bytecode_length
        );
      }
      RETURNERR(NAIE_ERR_CODEOVERFLOW);
    }
    if (engine->flags & NAIE_FLAG_DILIGENT) {
      ++(engine->forensics.noinstructions);
      if (engine->stack.count > engine->forensics.maxstackdepth) {
        engine->forensics.maxstackdepth = engine->stack.count;
      }
    }
    if (engine->flags & NAIE_FLAG_DEBUG) {
      naie_debug_state(engine, 0);
    }
    switch (opcode) {

    case OPCODE_NOOP:
      engine->bytecode_pos += instruction_size;
      goto NEXT;

    case OPCODE_SCR_CALL:
      param1 = GET_32BIT_VALUE(engine->bytecode, engine->bytecode_pos + 4);
      scalar1 = (naie_scalar_t){
        .type = NAIE_SCALAR_TYPE_STACKRETURN,
        .value._return = engine->bytecode_pos + 8
      };
      CHECK(naie_fstack_push(&(engine->fstack), scalar1));
      engine->bytecode_pos = param1;
      goto NEXT;

    case OPCODE_SCR_RET:
      CHECK(naie_fstack_pop(&(engine->fstack), &scalar1));
      if (scalar1.type != NAIE_SCALAR_TYPE_STACKRETURN) {
        //.. error
      }
      engine->bytecode_pos = scalar1.value._return;
      goto NEXT;

    case OPCODE_SCR_PUSH:
      scalar1 = *((naie_scalar_t*)(engine->bytecode + engine->bytecode_pos+4));
      CHECK(naie_fstack_push(&(engine->fstack), scalar1));
      engine->bytecode_pos += instruction_size;
      goto NEXT;

    case OPCODE_SCR_ADD:
      CHECK(naie_fstack_pop(&(engine->fstack), &scalar1));
      CHECK(naie_fstack_pop(&(engine->fstack), &scalar2));
      CHECK(naie_scalar_add(scalar1, scalar2, &scalar3));
      CHECK(naie_fstack_push(&(engine->fstack), scalar3));
      engine->bytecode_pos += instruction_size;
      goto NEXT;

    default:
      RETURNERR(NAIE_ERR_BADOPCODE);
    }
NEXT: ;
  }
}
