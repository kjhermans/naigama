/**
 * This file is part of NAIG.
 * Copyright 2019, KJ Hermans
 * Written by KJ Hermans <kees.jan.hermans@gmail.com>
 *
 * LICENSE:
 * Withheld
 *
 * \file
 * \brief
 */

#include <ctype.h>

#include <naigama/engine/naie.h>

NAIG_ERR_T naie_engine_run
  (
    naie_engine_t* engine,
    const unsigned char* bytecode,
    const unsigned bytecode_length,
    const unsigned char* data,
    const unsigned data_length,
    naie_result_t* result
  )
{
  unsigned bytecode_pos = 0;
  uint32_t opcode, param1, param2, param3;
  naie_stackentry_t entry, * entryptr;
  naie_action_t action;
  const unsigned char* set;
  unsigned instruction_size;
  unsigned char* value;
  unsigned valuesize;

  memset(result, 0, sizeof(naie_result_t));
  engine->inputpos = 0;
  while (1) {
    if (bytecode_pos > bytecode_length - 4) {
      RETURNERR(NAIE_ERR_CODEOVERFLOW);
    }
    opcode = GET_32BIT_NWO(bytecode, bytecode_pos);
    instruction_size = ((opcode >> 16) & 0xff) + 4;
    if (bytecode_pos + instruction_size > bytecode_length) {
#ifdef _DEBUG
      fprintf(stderr, "ERROR: Bytecode offset %u, instruction size %u; > %u\n"
        , bytecode_pos, instruction_size, bytecode_length
      );
#endif
      RETURNERR(NAIE_ERR_CODEOVERFLOW);
    }
    if (engine->diligent) {
      ++(engine->noinstructions);
      if (engine->stack.size > engine->maxstackdepth) {
        engine->maxstackdepth = engine->stack.size;
      }
    }

#ifdef _DEBUG
    if (engine->debug) {
      char copy[ 9 ];
      unsigned i;
      memset(copy, 0, sizeof(copy));
      memcpy(
        copy,
        data + engine->inputpos,
        (sizeof(copy) < data_length - engine->inputpos)
          ? sizeof(copy)
          : data_length - engine->inputpos
      );
      for (i=0; i < engine->labelmap.size; i++) {
        if (engine->labelmap.entries[ i ].offset == bytecode_pos) {
          fprintf(stderr, "Label: %s\n", engine->labelmap.entries[ i ].label);
        }
      }
      for (i=0; i < sizeof(copy); i++) {
        if (!isprint(copy[ i ])) { copy[ i ] = '.'; }
      }
      copy[ sizeof(copy) - 1 ] = 0;
      fprintf(stderr,
        "%13s @ %.6u txt: @ %.6u %s stk:"
        , naie_instr_string(opcode)
        , bytecode_pos
        , engine->inputpos
        , copy
      );
      unsigned s = 0;
      for (i=0; i < engine->stack.size; i++) {
        if (engine->stack.entries[ i ].type == NAIG_STACK_CATCH) {
          s = i;
        }
      }
      if (s && s > engine->stack.size - 8) {
        s = engine->stack.size - 8;
      }
      fprintf(stderr, "(%.3u prec.) ", s);
      for (i=s; i < engine->stack.size; i++) {
        fprintf(stderr, "%s:%u "
          , ((engine->stack.entries[ i ].type == NAIG_STACK_CALL)
              ? "CLL" : "ALT")
          , engine->stack.entries[ i ].address
        );
      }
      fprintf(stderr, "\n");
    }
#endif

    switch (opcode) {

    case OPCODE_NOOP:
      bytecode_pos += instruction_size;
      goto NEXT;

    case OPCODE_ANY:
      if (engine->inputpos < data_length) {
        ++(engine->inputpos);
        bytecode_pos += instruction_size;
      } else {
        goto FAIL;
      }
      goto NEXT;

    case OPCODE_SKIP:
      param1 = GET_32BIT_NWO(bytecode, bytecode_pos + 4);
      if (engine->inputpos <= data_length - param1) {
        engine->inputpos += param1;
        bytecode_pos += instruction_size;
      } else {
        goto FAIL;
      }
      goto NEXT;

    case OPCODE_CALL:
      param1 = GET_32BIT_NWO(bytecode, bytecode_pos + 4);
      CHECK(
        naie_stack_push(
          engine,
          NAIG_STACK_CALL,
          bytecode_pos + instruction_size
        )
      );
      bytecode_pos = param1;
      goto NEXT;

    case OPCODE_CHAR:
      if (engine->inputpos >= data_length) {
        goto FAIL;
      }
      param1 = bytecode[ bytecode_pos + 7 ];  // match
      if (data[ engine->inputpos ] == param1) {
        ++(engine->inputpos);
        bytecode_pos += instruction_size;
      } else {
        goto FAIL;
      }
      goto NEXT;

    case OPCODE_QUAD:
      set = bytecode + bytecode_pos + 4;
      if (engine->inputpos <= data_length - 4
          && 0 == memcmp(data + engine->inputpos, set, 4))
      {
        engine->inputpos += 4;
        bytecode_pos += instruction_size;
      } else {
        goto FAIL;
      }
      goto NEXT;

    case OPCODE_CATCH:
      param1 = GET_32BIT_NWO(bytecode, bytecode_pos + 4);
      CHECK(naie_stack_push(engine, NAIG_STACK_CATCH, param1));
      bytecode_pos += instruction_size;
      goto NEXT;

    case OPCODE_COMMIT:
      param1 = GET_32BIT_NWO(bytecode, bytecode_pos + 4);
      CHECK(naie_stack_pop(engine, &entry));
      if (entry.type == NAIG_STACK_CATCH) {
        bytecode_pos = param1;
      } else {
        RETURNERR(NAIE_ERR_STACKCORRUPT);
      }
      goto NEXT;

    case OPCODE_END:
      param1 = GET_32BIT_NWO(bytecode, bytecode_pos + 4);
      result->code = param1;
      CHECK(naie_fill_result(engine, result));
      return NAIG_OK;

    case OPCODE_FAIL:
      goto FAIL;

    case OPCODE_FAILTWICE:
      CHECK(naie_stack_pop(engine, &entry));
      if (entry.type != NAIG_STACK_CATCH) {
        RETURNERR(NAIE_ERR_STACKCORRUPT);
      }
      goto FAIL;

    case OPCODE_BACKCOMMIT:
      param1 = GET_32BIT_NWO(bytecode, bytecode_pos + 4);
      if (engine->stack.size) {
        CHECK(naie_stack_pop(engine, &entry));
        if (entry.type == NAIG_STACK_CATCH) {
          bytecode_pos = param1;
          engine->inputpos = entry.inputpos;
          engine->actions.size = entry.actioncount;
        } else {
          RETURNERR(NAIE_ERR_STACKCORRUPT);
        }
      } else {
        RETURNERR(NAIE_ERR_STACKCORRUPT);
      }
      goto NEXT;

    case OPCODE_JUMP:
      param1 = GET_32BIT_NWO(bytecode, bytecode_pos + 4);
      bytecode_pos = param1;
      goto NEXT;

    case OPCODE_OPENCAPTURE:
      param1 = GET_32BIT_NWO(bytecode, bytecode_pos + 4);
      action = (naie_action_t){
        .action = NAIG_ACTION_OPENCAPTURE,
        .slot = param1
      };
      CHECK(naie_action_push(engine, action));
      bytecode_pos += instruction_size;
      goto NEXT;

    case OPCODE_CLOSECAPTURE:
      param1 = GET_32BIT_NWO(bytecode, bytecode_pos + 4);
      action = (naie_action_t){
        .action = NAIG_ACTION_CLOSECAPTURE,
        .slot = param1
      };
      CHECK(naie_action_push(engine, action));
      bytecode_pos += instruction_size;
      goto NEXT;

    case OPCODE_REPLACE:
      param1 = GET_32BIT_NWO(bytecode, bytecode_pos + 4);
      if (param2 > bytecode_length - 8) {
        RETURNERR(NAIE_ERR_CODEOVERFLOW);
      }
      param2 = GET_32BIT_NWO(bytecode, param1);
      if (param2 != OPCODE_REPLACESTRING) {
        RETURNERR(NAIE_ERR_BADOPCODE);
      }
      param2 = GET_32BIT_NWO(bytecode, param1 + 4);
      if (param1 + 8 + param2 > bytecode_length) {
        RETURNERR(NAIE_ERR_CODEOVERFLOW);
      }
      action = (naie_action_t){
        .action = NAIG_ACTION_REPLACE,
        .slot = param1 + 8,
        .intvalue = param2
      };
      CHECK(naie_action_push(engine, action));
      bytecode_pos += instruction_size;
      goto NEXT;

    case OPCODE_PARTIALCOMMIT:
      param1 = GET_32BIT_NWO(bytecode, bytecode_pos + 4);
      CHECK(naie_stack_peek(engine, &entryptr));
      if (entryptr->type != NAIG_STACK_CATCH) {
        RETURNERR(NAIE_ERR_STACKCORRUPT);
      }
      entryptr->inputpos = engine->inputpos;
      entryptr->actioncount = engine->actions.size;
      bytecode_pos = param1;
      goto NEXT;

    case OPCODE_RET:
      CHECK(naie_stack_pop(engine, &entry));
      if (entry.type != NAIG_STACK_CALL) {
        RETURNERR(NAIE_ERR_STACKCORRUPT);
      }
      bytecode_pos = entry.address;
      goto NEXT;

    case OPCODE_SET:
      set = bytecode + bytecode_pos + 4;
      if (engine->inputpos < data_length
          && DATAINSET(set, data[ engine->inputpos ]))
      {
        ++(engine->inputpos);
        bytecode_pos += instruction_size;
      } else {
        goto FAIL;
      }
      goto NEXT;

    case OPCODE_SPAN:
      set = bytecode + bytecode_pos + 4;
      while (engine->inputpos < data_length
             && DATAINSET(set, data[ engine->inputpos ]))
      {
        ++(engine->inputpos);
      }
      bytecode_pos += instruction_size;
      goto NEXT;

    case OPCODE_TESTANY:
      param1 = GET_32BIT_NWO(bytecode, bytecode_pos + 4);
      if (engine->inputpos < data_length) {
        bytecode_pos += instruction_size;
      } else {
        bytecode_pos = param1;
      }
      goto NEXT;

    case OPCODE_TESTCHAR:
      param1 = GET_32BIT_NWO(bytecode, bytecode_pos + 4); // address
      param2 = bytecode[ bytecode_pos + 9 ];              // mask
      param3 = bytecode[ bytecode_pos + 11 ];             // match
      if (param2 == 0) { param2 = 0xff; }
      if (engine->inputpos < data_length
          && (data[ engine->inputpos ] & param2) == param3)
      {
        bytecode_pos += instruction_size;
      } else {
        bytecode_pos = param1;
      }
      goto NEXT;

    case OPCODE_TESTSET:
      param1 = GET_32BIT_NWO(bytecode, bytecode_pos + 4);
      set = bytecode + bytecode_pos + 8;
      if (engine->inputpos < data_length
          && DATAINSET(set, data[ engine->inputpos ]))
      {
        bytecode_pos += instruction_size;
      } else {
        bytecode_pos = param1;
      }
      goto NEXT;

    case OPCODE_VAR:
      param1 = GET_32BIT_NWO(bytecode, bytecode_pos + 4);
      CHECK(naie_variable(engine, data, param1, &value, &valuesize));
      if (engine->inputpos + valuesize < data_length
          && 0 == memcmp(data + engine->inputpos, value, valuesize))
      {
        engine->inputpos += valuesize;
        bytecode_pos += instruction_size;
      } else {
        goto FAIL;
      }
      goto NEXT;

    case OPCODE_COUNTER:
      param1 = GET_32BIT_NWO(bytecode, bytecode_pos + 4);
      param2 = GET_32BIT_NWO(bytecode, bytecode_pos + 8);
      CHECK(naie_register_store(engine, param1, param2));
      bytecode_pos += instruction_size;
      goto NEXT;

    case OPCODE_CONDJUMP:
      param1 = GET_32BIT_NWO(bytecode, bytecode_pos + 4);
      param2 = GET_32BIT_NWO(bytecode, bytecode_pos + 8);
      CHECK(naie_register_retrieve(engine, param1, &param3));
      if (param3 == 1) {
        bytecode_pos += instruction_size;
      } else {
        bytecode_pos = param2;
      }
      goto NEXT;

    default:
#ifdef _DEBUG
      fprintf(stderr,
        "Unknown instruction opcode %.8x at %u\n"
        , opcode, bytecode_pos
      );
#endif
      RETURNERR(NAIE_ERR_BADOPCODE);

    }

FAIL:

#ifdef _DEBUG
    if (engine->debug) {
      fprintf(stderr, "======== FAIL\n");
    }
#endif

    while (engine->stack.size) {
      CHECK(naie_stack_pop(engine, &entry));
      if (entry.type == NAIG_STACK_CATCH) {
        bytecode_pos = entry.address;
        engine->inputpos = entry.inputpos;
        engine->actions.size = entry.actioncount;
        goto NEXT;
      }
    }
    engine->actions.size = 0;
    result->code = -1;
    return NAIG_FAILURE;
NEXT:
    ;
  }
  RETURNERR(NAIE_ERR_CODEOVERFLOW);
}
