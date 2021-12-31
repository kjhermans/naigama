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

#include "naie_private.h"

/**
 * Runs the bytecode, from the beginning, against the input,
 * also from the beginning. Ends when either a FAIL condition
 * eats up the entire stack (no match), or the 'end' instruction
 * is encountered (natch). Or an abnormal situation is encountered.
 *
 * \param engine  Initialized engine
 * \param result  Uninitialized result, contains all relevant
 *                end code / capture data / replace data
 *                when this function returns.
 * \returns       NAIG_OK on success, NAIG_FAILURE on no match, or
 *                any other error on abnormal end.
 */
NAIG_ERR_T naie_engine_loop
  (
    naie_engine_t* engine,
    naio_result_t* result
  )
{
  uint32_t opcode, param1, param2, param3;
  naie_stackentry_t entry, * entryptr;
  naie_action_t action;
  const unsigned char* set;
  unsigned instruction_size;
  unsigned char* value;
  unsigned valuesize;
#ifdef _DEBUG
  fprintf(stderr, "Processing %u bytes of input\n", engine->input_length);
#endif

  while (1) {
    if (engine->bytecode_pos > engine->bytecode_length - 4) {
      RETURNERR(NAIG_ERR_CODEOVERFLOW);
    }
    if (engine->bytecode_pos % 4) {
      RETURNERR(NAIG_ERR_BITFAULT);
    }
    CHECK(naie_engine_endless_loop(engine));
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
    ++(engine->forensics.noinstructions);
    if (engine->stack.count > engine->forensics.maxstackdepth) {
      engine->forensics.maxstackdepth = engine->stack.count;
    }
    if (engine->config.maxnoinstructions) {
      if (engine->forensics.noinstructions > engine->config.maxnoinstructions) {
        RETURNERR(NAIG_ERR_MAXINSTR);
      }
    }
    if (engine->config.maxstackdepth) {
      if (engine->forensics.maxstackdepth > engine->config.maxstackdepth) {
        RETURNERR(NAIG_ERR_MAXSTACK);
      }
    }
    if (engine->flags & NAIE_FLAG_DEBUG) {
      if (engine->debugger) {
        CHECK(engine->debugger(engine, opcode, engine->debugarg));
      }
    }

    switch (opcode) {

    case OPCODE_NOOP:
      engine->bytecode_pos += instruction_size;
      goto NEXT;

    case OPCODE_ANY:
      if (engine->input_pos < engine->input_length) {
        ++(engine->input_pos);
        engine->bytecode_pos += instruction_size;
      } else {
        goto FAIL;
      }
      goto NEXT;

    case OPCODE_SKIP:
      param1 = GET_32BIT_VALUE(engine->bytecode, engine->bytecode_pos + 4);
      if (engine->input_pos <= engine->input_length - param1) {
        engine->input_pos += param1;
        engine->bytecode_pos += instruction_size;
      } else {
        goto FAIL;
      }
      goto NEXT;

    case OPCODE_INTRPCAPTURE:
      param1 = GET_32BIT_VALUE(engine->bytecode, engine->bytecode_pos + 4);
      param2 = GET_32BIT_VALUE(engine->bytecode, engine->bytecode_pos + 8);
      CHECK(naie_variable(engine, engine->input, param1, &value, &valuesize));
      if (valuesize == 0) {
        RETURNERR(NAIG_ERR_INTRPCAPTURE);
      }
      switch (param2) {
      case NAIG_INTRPCAPTURE_RUINT32:
        if (valuesize <= 4) {
          engine->reg_ilen =
            (value[ 0 ] << ((valuesize-1) * 8)) |
            ((valuesize > 1) ? (value[ 1 ] << ((valuesize-2) * 8)) : 0) |
            ((valuesize > 2) ? (value[ 2 ] << ((valuesize-3) * 8)) : 0) |
            ((valuesize > 3) ? (value[ 3 ]) : 0);
          engine->reg_ilen += engine->input_pos;
          if (engine->reg_ilen > engine->input_length) {
            RETURNERR(NAIG_ERR_INTRPCAPTURE);
          }
          engine->reg_ilen_set = 1;
        } else {
          RETURNERR(NAIG_ERR_INTRPCAPTURE);
        }
      }
      engine->bytecode_pos += instruction_size;
      goto NEXT;

    case OPCODE_CALL:
      param1 = GET_32BIT_VALUE(engine->bytecode, engine->bytecode_pos + 4);
      CHECK(
        naie_stack_push(
          engine,
          NAIG_STACK_CALL,
          engine->bytecode_pos + instruction_size,
          engine->input_length
        )
      );
      engine->bytecode_pos = param1;
      if (engine->reg_ilen_set) {
        engine->input_length = engine->reg_ilen;
        engine->reg_ilen_set = 0;
        engine->reg_ilen = 0;
      }
      goto NEXT;

    case OPCODE_CHAR:
      if (engine->input_pos >= engine->input_length) {
        goto FAIL;
      }
      param1 = GET_32BIT_VALUE(engine->bytecode, engine->bytecode_pos + 4);
      if (engine->input[ engine->input_pos ] == param1) {
        ++(engine->input_pos);
        engine->bytecode_pos += instruction_size;
      } else {
        goto FAIL;
      }
      goto NEXT;

    case OPCODE_MASKEDCHAR:
      if (engine->input_pos >= engine->input_length) {
        goto FAIL;
      }
      param1 = engine->bytecode[ engine->bytecode_pos + 7 ];  // maskedmatch
      param2 = engine->bytecode[ engine->bytecode_pos + 11 ]; // mask
      if ((engine->input[ engine->input_pos ] & param2) == param1) {
        ++(engine->input_pos);
        engine->bytecode_pos += instruction_size;
      } else {
        goto FAIL;
      }
      goto NEXT;

    case OPCODE_QUAD:
      set = engine->bytecode + engine->bytecode_pos + 4;
      if (engine->input_pos <= engine->input_length - 4
          && 0 == memcmp(engine->input + engine->input_pos, set, 4))
      {
        engine->input_pos += 4;
        engine->bytecode_pos += instruction_size;
      } else {
        goto FAIL;
      }
      goto NEXT;

    case OPCODE_CATCH:
      param1 = GET_32BIT_VALUE(engine->bytecode, engine->bytecode_pos + 4);
      CHECK(naie_stack_push(engine, NAIG_STACK_CATCH, param1, 0));
      engine->bytecode_pos += instruction_size;
      goto NEXT;

    case OPCODE_COMMIT:
      param1 = GET_32BIT_VALUE(engine->bytecode, engine->bytecode_pos + 4);
      CHECK(naie_stack_pop(engine, &entry));
      if (entry.type == NAIG_STACK_CATCH) {
        engine->bytecode_pos = param1;
      } else {
        RETURNERR(NAIG_ERR_STACKCORRUPT);
      }
      goto NEXT;

    case OPCODE_END:
      param1 = GET_32BIT_VALUE(engine->bytecode, engine->bytecode_pos + 4);
      result->code = param1;
      CHECK(naie_result_fill(engine, result));
      return NAIG_OK;

    case OPCODE_FAIL:
      goto FAIL;

    case OPCODE_FAILTWICE:
      CHECK(naie_stack_pop(engine, &entry));
      if (entry.type != NAIG_STACK_CATCH) {
        RETURNERR(NAIG_ERR_STACKCORRUPT);
      }
      goto FAIL;

    case OPCODE_BACKCOMMIT:
      param1 = GET_32BIT_VALUE(engine->bytecode, engine->bytecode_pos + 4);
      if (engine->stack.count) {
        CHECK(naie_stack_pop(engine, &entry));
        if (entry.type == NAIG_STACK_CATCH) {
          engine->bytecode_pos = param1;
          engine->input_pos = entry.input_pos;
          engine->actions.count = entry.actioncount;
        } else {
          RETURNERR(NAIG_ERR_STACKCORRUPT);
        }
      } else {
        RETURNERR(NAIG_ERR_STACKCORRUPT);
      }
      goto NEXT;

    case OPCODE_JUMP:
      param1 = GET_32BIT_VALUE(engine->bytecode, engine->bytecode_pos + 4);
      engine->bytecode_pos = param1;
      goto NEXT;

    case OPCODE_OPENCAPTURE:
      param1 = GET_32BIT_VALUE(engine->bytecode, engine->bytecode_pos + 4);
      action = (naie_action_t){
        .action = NAIG_ACTION_OPENCAPTURE,
        .slot = param1,
        .inputpos = engine->input_pos
      };
      CHECK(naie_action_push(engine, action));
      engine->bytecode_pos += instruction_size;
      goto NEXT;

    case OPCODE_CLOSECAPTURE:
      param1 = GET_32BIT_VALUE(engine->bytecode, engine->bytecode_pos + 4);
      action = (naie_action_t){
        .action = NAIG_ACTION_CLOSECAPTURE,
        .slot = param1,
        .inputpos = engine->input_pos
      };
      CHECK(naie_action_push(engine, action));
      engine->bytecode_pos += instruction_size;
      goto NEXT;

    case OPCODE_REPLACE:
      param1 = GET_32BIT_VALUE(engine->bytecode, engine->bytecode_pos + 4);
      param2 = GET_32BIT_VALUE(engine->bytecode, engine->bytecode_pos + 8);
      if (engine->flags & NAIE_FLAG_DOREPLACE) {
        engine->bytecode_pos += instruction_size;
        CHECK(naie_engine_loop_replace(engine, param1));
      } else {
        engine->bytecode_pos = param2;
      }
      goto NEXT;

    case OPCODE_PARTIALCOMMIT:
      param1 = GET_32BIT_VALUE(engine->bytecode, engine->bytecode_pos + 4);
      CHECK(naie_stack_peek(engine, &entryptr));
      if (entryptr->type != NAIG_STACK_CATCH) {
        RETURNERR(NAIG_ERR_STACKCORRUPT);
      }
      entryptr->input_pos = engine->input_pos;
      entryptr->actioncount = engine->actions.count;
      engine->bytecode_pos = param1;
      goto NEXT;

    case OPCODE_RET:
      CHECK(naie_stack_pop(engine, &entry));
      switch (entry.type) {
      case NAIG_STACK_CALL:
        engine->input_length = entry.input_length;
        break;
      case NAIG_STACK_END:
        result->code = 0;
        CHECK(naie_result_fill(engine, result));
        return NAIG_OK;
      case NAIG_STACK_CATCH:
        RETURNERR(NAIG_ERR_STACKCORRUPT);
      default:
        RETURNERR(NAIG_ERR_BITFAULT);
      }
      engine->bytecode_pos = entry.address;
      goto NEXT;

    case OPCODE_SET:
      set = engine->bytecode + engine->bytecode_pos + 4;
      if (engine->input_pos < engine->input_length
          && DATAINSET(set, engine->input[ engine->input_pos ]))
      {
        ++(engine->input_pos);
        engine->bytecode_pos += instruction_size;
      } else {
        goto FAIL;
      }
      goto NEXT;

    case OPCODE_SPAN:
      set = engine->bytecode + engine->bytecode_pos + 4;
      while (engine->input_pos < engine->input_length
             && DATAINSET(set, engine->input[ engine->input_pos ]))
      {
        ++(engine->input_pos);
      }
      engine->bytecode_pos += instruction_size;
      goto NEXT;

    case OPCODE_TESTANY:
      param1 = GET_32BIT_VALUE(engine->bytecode, engine->bytecode_pos + 4);
      if (engine->input_pos < engine->input_length) {
        engine->bytecode_pos += instruction_size;
      } else {
        engine->bytecode_pos = param1;
      }
      goto NEXT;

    case OPCODE_TESTCHAR:
      param1 = GET_32BIT_VALUE(engine->bytecode, engine->bytecode_pos + 4);
      param2 = engine->bytecode[ engine->bytecode_pos + 11 ];
      if (engine->input_pos < engine->input_length
          && engine->input[ engine->input_pos ] == param2)
      {
        engine->bytecode_pos += instruction_size;
      } else {
        engine->bytecode_pos = param1;
      }
      goto NEXT;

    case OPCODE_TESTSET:
      param1 = GET_32BIT_VALUE(engine->bytecode, engine->bytecode_pos + 4);
      set = engine->bytecode + engine->bytecode_pos + 8;
      if (engine->input_pos < engine->input_length
          && DATAINSET(set, engine->input[ engine->input_pos ]))
      {
        engine->bytecode_pos += instruction_size;
      } else {
        engine->bytecode_pos = param1;
      }
      goto NEXT;

    case OPCODE_VAR:
      param1 = GET_32BIT_VALUE(engine->bytecode, engine->bytecode_pos + 4);
      CHECK(naie_variable(engine, engine->input, param1, &value, &valuesize));
      if (valuesize == 0) {
        goto FAIL;
      }
      if (engine->input_pos + valuesize <= engine->input_length
          && 0 == memcmp(engine->input + engine->input_pos, value, valuesize))
      {
        engine->input_pos += valuesize;
        engine->bytecode_pos += instruction_size;
      } else {
        goto FAIL;
      }
      goto NEXT;

    case OPCODE_COUNTER:
      param1 = GET_32BIT_VALUE(engine->bytecode, engine->bytecode_pos + 4);
      param2 = GET_32BIT_VALUE(engine->bytecode, engine->bytecode_pos + 8);
      CHECK(naie_register_store(engine, param1, param2));
      engine->bytecode_pos += instruction_size;
      goto NEXT;

    case OPCODE_CONDJUMP:
      param1 = GET_32BIT_VALUE(engine->bytecode, engine->bytecode_pos + 4);
      param2 = GET_32BIT_VALUE(engine->bytecode, engine->bytecode_pos + 8);
      CHECK(naie_register_retrieve(engine, param1, &param3));
      if (param3 == 1) {
        engine->bytecode_pos += instruction_size;
      } else {
        engine->bytecode_pos = param2;
      }
      goto NEXT;

    case OPCODE_ISOLATE:
      param1 = GET_32BIT_VALUE(engine->bytecode, engine->bytecode_pos + 4);
      {
        unsigned stop, i;
        for (i = engine->actions.count; i > 0; i--) {
          switch (engine->actions.entries[ i-1 ].action) {
          case NAIG_ACTION_CLOSECAPTURE:
            if (engine->actions.entries[ i-1 ].slot == param1) {
              stop = engine->actions.entries[ i-1 ].inputpos;
              for (--i; i > 0; i--) {
                switch (engine->actions.entries[ i-1 ].action) {
                case NAIG_ACTION_OPENCAPTURE:
                  if (engine->actions.entries[ i-1 ].slot == param1) {
                    unsigned start = engine->actions.entries[ i-1 ].inputpos;
                    unsigned origpos = engine->input_pos;
                    unsigned origlength = engine->input_length;
                    const unsigned char* originput = engine->input;
                    engine->input = engine->input + start;
                    engine->input_pos = 0;
                    engine->input_length = (stop - start);
                    engine->bytecode_pos += instruction_size;
                    if (NAIG_ISOK(naie_engine_loop(engine, result))) {
                      engine->input_pos = origpos;
                      engine->input = originput;
                      engine->input_length = origlength;
                      goto NEXT;
                    }
                  }
                }
              }
              RETURNERR(NAIG_ERR_ACTIONLIST);
            }
          }
        }
      }
      RETURNERR(NAIG_ERR_ACTIONLIST);

    case OPCODE_ENDISOLATE:
      engine->bytecode_pos += instruction_size;
      return NAIG_OK;

    case OPCODE_TRAP:
      RETURNERR(NAIG_ERR_TRAP);

    default:
//      if (engine->flags & NAIE_FLAG_DEBUG) {
        fprintf(stderr,
          "Unknown instruction opcode %.8x at %u\n"
          , opcode, engine->bytecode_pos
        );
//      }
      RETURNERR(NAIG_ERR_BADOPCODE);

    }

FAIL:
    if (engine->flags & NAIE_FLAG_DEBUG) {
      if (engine->debugger) {
        CHECK(engine->debugger(engine, 0xffffffff, engine->debugarg));
      }
    }
    engine->forensics.stacksizebeforefail = engine->stack.count;
    while (engine->stack.count) {
      CHECK(naie_stack_pop(engine, &entry));
      switch (entry.type) {
      case NAIG_STACK_CATCH:
        engine->bytecode_pos = entry.address;
        engine->input_pos = entry.input_pos;
        engine->actions.count = entry.actioncount;
        goto NEXT;
      case NAIG_STACK_CALL:
        engine->input_length = entry.input_length;
      }
    }
    engine->actions.count = 0;
    result->code = -1;
    return NAIG_ERR_ENGINE;

NEXT: ;

  }
}
