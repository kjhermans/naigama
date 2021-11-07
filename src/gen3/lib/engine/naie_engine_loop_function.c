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

#include <naigama/builtins.h>
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
      RETURNERR(NAIG_ERR_CODEOVERFLOW);
    }
    opcode = GET_32BIT_VALUE(engine->bytecode, engine->bytecode_pos);
    instruction_size = ((opcode >> 16) & 0xff) + 4;
    if (engine->bytecode_pos + instruction_size > engine->bytecode_length) {
      if (engine->flags & NAIE_FLAG_DEBUG) {
        fprintf(stderr, "ERROR: Bytecode offset %u, instruction size %u; > %u\n"
          , engine->bytecode_pos, instruction_size, engine->bytecode_length
        );
      }
      RETURNERR(NAIG_ERR_CODEOVERFLOW);
    }
    if (engine->flags & NAIE_FLAG_DILIGENT) {
      ++(engine->forensics.noinstructions);
      if (engine->stack.count > engine->forensics.maxstackdepth) {
        engine->forensics.maxstackdepth = engine->stack.count;
      }
    }
    if (engine->flags & NAIE_FLAG_DEBUG) {
      fprintf(stderr, "%.6u %s\n", engine->bytecode_pos, naie_instr_string(opcode));
      naie_debug_script(engine);
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
      engine->lastfunc = engine->fstack.nelts;
      engine->bytecode_pos = param1;
      goto NEXT;

    case OPCODE_SCR_BUILTIN:
      param1 = GET_32BIT_VALUE(engine->bytecode, engine->bytecode_pos + 4);
      switch (param1) {
      case NAIG_BUILTIN_ERROR:
      case NAIG_BUILTIN_PRINT:
      case NAIG_BUILTIN_READ:
break;
      }
      engine->bytecode_pos += instruction_size;
      goto NEXT;

    case OPCODE_JUMP:
      param1 = GET_32BIT_VALUE(engine->bytecode, engine->bytecode_pos + 4);
      engine->bytecode_pos = param1;
      goto NEXT;

    case OPCODE_SCR_CONDJUMP:
      CHECK(naie_fstack_pop_deref(engine, &scalar1));
      param1 = GET_32BIT_VALUE(engine->bytecode, engine->bytecode_pos + 4);
      if (!scalar1.value._int) {
        engine->bytecode_pos = param1;
      }
      goto NEXT;

    case OPCODE_SCR_SHIFT:
      param1 = GET_32BIT_VALUE(engine->bytecode, engine->bytecode_pos + 4);
      CHECK(naie_fstack_shift(&(engine->fstack), param1, &scalar1));
      if (scalar1.type == NAIE_SCALAR_TYPE_STACKRETURN) {
//.. dereference the elements from 0 to param1
        if (engine->fstack.nelts >= param1) {
          engine->lastfunc -= param1;
        } else {
          //.. error
        }
      }
      engine->bytecode_pos += instruction_size;
      goto NEXT;

    case OPCODE_SCR_RET:
      {
        unsigned i, callbelow = 0;
        for (i=0; i < engine->fstack.nelts; i++) {
          CHECK(naie_fstack_peek(&(engine->fstack), &scalar1, i));
          if (scalar1.type == NAIE_SCALAR_TYPE_STACKRETURN) {
            for (++i; i < engine->fstack.nelts; i++) {
              CHECK(naie_fstack_peek(&(engine->fstack), &scalar2, i));
              if (scalar2.type == NAIE_SCALAR_TYPE_STACKRETURN) {
                callbelow = i;
                break;
              }
            }
            CHECK(naie_fstack_get(&(engine->fstack), engine->lastfunc, &scalar3));
            CHECK(naie_scalar_dereference(engine, &scalar3));
            engine->fstack.nelts = engine->lastfunc-1;
            CHECK(naie_fstack_push(&(engine->fstack), scalar3));
            engine->lastfunc = callbelow;
            engine->bytecode_pos = scalar1.value._return;
            goto NEXT;
          }
        }
        return NAIG_ERR_STACKCORRUPT;
      }

    case OPCODE_SCR_PUSH:
      CHECK(
        naie_scalar_convert(
          (uint32_t*)(engine->bytecode + engine->bytecode_pos + 4),
          &scalar1
        )
      );
      CHECK(naie_fstack_push(&(engine->fstack), scalar1));
      engine->bytecode_pos += instruction_size;
      goto NEXT;

    case OPCODE_SCR_POP:
      CHECK(naie_fstack_pop(&(engine->fstack), NULL));
      engine->bytecode_pos += instruction_size;
      goto NEXT;

    case OPCODE_SCR_ADD:
      CHECK(naie_fstack_pop_deref(engine, &scalar1));
      CHECK(naie_fstack_pop_deref(engine, &scalar2));
      CHECK(naie_scalar_add(scalar1, scalar2, &scalar3));
      CHECK(naie_fstack_push(&(engine->fstack), scalar3));
      engine->bytecode_pos += instruction_size;
      goto NEXT;

    case OPCODE_SCR_MUL:
      CHECK(naie_fstack_pop_deref(engine, &scalar1));
      CHECK(naie_fstack_pop_deref(engine, &scalar2));
      CHECK(naie_scalar_mul(scalar1, scalar2, &scalar3));
      CHECK(naie_fstack_push(&(engine->fstack), scalar3));
      engine->bytecode_pos += instruction_size;
      goto NEXT;

    case OPCODE_SCR_ASSIGN:
      CHECK(naie_fstack_pop(&(engine->fstack), &scalar1));
      CHECK(naie_fstack_pop_deref(engine, &scalar2));
      CHECK(naie_scalar_assign(engine, scalar1, scalar2, &scalar3));
      CHECK(naie_fstack_push(&(engine->fstack), scalar3));
      engine->bytecode_pos += instruction_size;
      goto NEXT;

    case OPCODE_SCR_EQUALS:
      CHECK(naie_fstack_pop_deref(engine, &scalar1));
      CHECK(naie_fstack_pop_deref(engine, &scalar2));
      CHECK(naie_scalar_equals(scalar1, scalar2, &scalar3));
      CHECK(naie_fstack_push(&(engine->fstack), scalar3));
      engine->bytecode_pos += instruction_size;
      goto NEXT;

    case OPCODE_SCR_LT:
      CHECK(naie_fstack_pop_deref(engine, &scalar1));
      CHECK(naie_fstack_pop_deref(engine, &scalar2));
      CHECK(naie_scalar_lt(scalar1, scalar2, &scalar3));
      CHECK(naie_fstack_push(&(engine->fstack), scalar3));
      engine->bytecode_pos += instruction_size;
      goto NEXT;

    case OPCODE_MODE:
      param1 = GET_32BIT_VALUE(engine->bytecode, engine->bytecode_pos + 4);
      engine->bytecode_pos += instruction_size;
      if (param1 == 0) {
        return NAIG_OK;
      }
      goto NEXT;

    default:
fprintf(stderr, "BAD OPCODE: %.6x\n", opcode);
      RETURNERR(NAIG_ERR_BADOPCODE);
    }
NEXT: ;
  }
}
