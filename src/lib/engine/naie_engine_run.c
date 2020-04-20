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

#include <naigama/engine/naie.h>

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
NAIG_ERR_T naie_engine_run
  (
    naie_engine_t* engine,
    naie_result_t* result
  )
{
  uint32_t opcode, param1, param2, param3;
  naie_stackentry_t entry, * entryptr;
  naie_action_t action;
  const unsigned char* set;
  unsigned instruction_size;
  unsigned char* value;
  unsigned valuesize;

  memset(result, 0, sizeof(naie_result_t));
  engine->bytecode_pos = 0;
  engine->input_pos = 0;
  while (1) {
    if (engine->bytecode_pos > engine->bytecode_length - 4) {
      RETURNERR(NAIE_ERR_CODEOVERFLOW);
    }
    opcode = GET_32BIT_NWO(engine->bytecode, engine->bytecode_pos);
    instruction_size = ((opcode >> 16) & 0xff) + 4;
    if (engine->bytecode_pos + instruction_size > engine->bytecode_length) {
      if (engine->debug) {
        fprintf(stderr, "ERROR: Bytecode offset %u, instruction size %u; > %u\n"
          , engine->bytecode_pos, instruction_size, engine->bytecode_length
        );
      }
      RETURNERR(NAIE_ERR_CODEOVERFLOW);
    }
    if (engine->diligent) {
      ++(engine->noinstructions);
      if (engine->stack.size > engine->maxstackdepth) {
        engine->maxstackdepth = engine->stack.size;
      }
    }
    if (engine->debug) {
      naie_debug_state(engine);
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
      param1 = GET_32BIT_NWO(engine->bytecode, engine->bytecode_pos + 4);
      if (engine->input_pos <= engine->input_length - param1) {
        engine->input_pos += param1;
        engine->bytecode_pos += instruction_size;
      } else {
        goto FAIL;
      }
      goto NEXT;

    case OPCODE_CALL:
      param1 = GET_32BIT_NWO(engine->bytecode, engine->bytecode_pos + 4);
      CHECK(
        naie_stack_push(
          engine,
          NAIG_STACK_CALL,
          engine->bytecode_pos + instruction_size
        )
      );
      engine->bytecode_pos = param1;
      goto NEXT;

    case OPCODE_CHAR:
      if (engine->input_pos >= engine->input_length) {
        goto FAIL;
      }
      param1 = engine->bytecode[ engine->bytecode_pos + 7 ];
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
      param1 = GET_32BIT_NWO(engine->bytecode, engine->bytecode_pos + 4);
      CHECK(naie_stack_push(engine, NAIG_STACK_CATCH, param1));
      engine->bytecode_pos += instruction_size;
      goto NEXT;

    case OPCODE_COMMIT:
      param1 = GET_32BIT_NWO(engine->bytecode, engine->bytecode_pos + 4);
      CHECK(naie_stack_pop(engine, &entry));
      if (entry.type == NAIG_STACK_CATCH) {
        engine->bytecode_pos = param1;
      } else {
        RETURNERR(NAIE_ERR_STACKCORRUPT);
      }
      goto NEXT;

    case OPCODE_END:
      param1 = GET_32BIT_NWO(engine->bytecode, engine->bytecode_pos + 4);
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
      param1 = GET_32BIT_NWO(engine->bytecode, engine->bytecode_pos + 4);
      if (engine->stack.size) {
        CHECK(naie_stack_pop(engine, &entry));
        if (entry.type == NAIG_STACK_CATCH) {
          engine->bytecode_pos = param1;
          engine->input_pos = entry.input_pos;
          engine->actions.size = entry.actioncount;
        } else {
          RETURNERR(NAIE_ERR_STACKCORRUPT);
        }
      } else {
        RETURNERR(NAIE_ERR_STACKCORRUPT);
      }
      goto NEXT;

    case OPCODE_JUMP:
      param1 = GET_32BIT_NWO(engine->bytecode, engine->bytecode_pos + 4);
      engine->bytecode_pos = param1;
      goto NEXT;

    case OPCODE_OPENCAPTURE:
      param1 = GET_32BIT_NWO(engine->bytecode, engine->bytecode_pos + 4);
      action = (naie_action_t){
        .action = NAIG_ACTION_OPENCAPTURE,
        .slot = param1
      };
      CHECK(naie_action_push(engine, action));
      engine->bytecode_pos += instruction_size;
      goto NEXT;

    case OPCODE_CLOSECAPTURE:
      param1 = GET_32BIT_NWO(engine->bytecode, engine->bytecode_pos + 4);
      action = (naie_action_t){
        .action = NAIG_ACTION_CLOSECAPTURE,
        .slot = param1
      };
      CHECK(naie_action_push(engine, action));
      engine->bytecode_pos += instruction_size;
      goto NEXT;

    case OPCODE_REPLACE:
      param1 = GET_32BIT_NWO(engine->bytecode, engine->bytecode_pos + 4);
      param2 = GET_32BIT_NWO(engine->bytecode, engine->bytecode_pos + 8);
      action = (naie_action_t){
        .action = NAIG_ACTION_REPLACE,
        .slot = param1
      };
      CHECK(naie_action_push(engine, action));
      engine->bytecode_pos = param2;
      goto NEXT;

    case OPCODE_PARTIALCOMMIT:
      param1 = GET_32BIT_NWO(engine->bytecode, engine->bytecode_pos + 4);
      CHECK(naie_stack_peek(engine, &entryptr));
      if (entryptr->type != NAIG_STACK_CATCH) {
        RETURNERR(NAIE_ERR_STACKCORRUPT);
      }
      entryptr->input_pos = engine->input_pos;
      entryptr->actioncount = engine->actions.size;
      engine->bytecode_pos = param1;
      goto NEXT;

    case OPCODE_RET:
      CHECK(naie_stack_pop(engine, &entry));
      if (entry.type != NAIG_STACK_CALL) {
        RETURNERR(NAIE_ERR_STACKCORRUPT);
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
      param1 = GET_32BIT_NWO(engine->bytecode, engine->bytecode_pos + 4);
      if (engine->input_pos < engine->input_length) {
        engine->bytecode_pos += instruction_size;
      } else {
        engine->bytecode_pos = param1;
      }
      goto NEXT;

    case OPCODE_TESTCHAR:
      param1 = GET_32BIT_NWO(engine->bytecode, engine->bytecode_pos + 4); // address
      param2 = engine->bytecode[ engine->bytecode_pos + 11 ];             // match
      if (engine->input_pos < engine->input_length
          && engine->input[ engine->input_pos ] == param2)
      {
        engine->bytecode_pos += instruction_size;
      } else {
        engine->bytecode_pos = param1;
      }
      goto NEXT;

    case OPCODE_TESTSET:
      param1 = GET_32BIT_NWO(engine->bytecode, engine->bytecode_pos + 4);
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
      param1 = GET_32BIT_NWO(engine->bytecode, engine->bytecode_pos + 4);
      CHECK(naie_variable(engine, engine->input, param1, &value, &valuesize));
      if (engine->input_pos + valuesize < engine->input_length
          && 0 == memcmp(engine->input + engine->input_pos, value, valuesize))
      {
        engine->input_pos += valuesize;
        engine->bytecode_pos += instruction_size;
      } else {
        goto FAIL;
      }
      goto NEXT;

    case OPCODE_COUNTER:
      param1 = GET_32BIT_NWO(engine->bytecode, engine->bytecode_pos + 4);
      param2 = GET_32BIT_NWO(engine->bytecode, engine->bytecode_pos + 8);
      CHECK(naie_register_store(engine, param1, param2));
      engine->bytecode_pos += instruction_size;
      goto NEXT;

    case OPCODE_CONDJUMP:
      param1 = GET_32BIT_NWO(engine->bytecode, engine->bytecode_pos + 4);
      param2 = GET_32BIT_NWO(engine->bytecode, engine->bytecode_pos + 8);
      CHECK(naie_register_retrieve(engine, param1, &param3));
      if (param3 == 1) {
        engine->bytecode_pos += instruction_size;
      } else {
        engine->bytecode_pos = param2;
      }
      goto NEXT;

    default:
      if (engine->debug) {
        fprintf(stderr,
          "Unknown instruction opcode %.8x at %u\n"
          , opcode, engine->bytecode_pos
        );
      }
      RETURNERR(NAIE_ERR_BADOPCODE);

    }

FAIL:
    if (engine->debug) {
      fprintf(stderr, "======== FAIL\n");
    }
    engine->stacksizebeforefail = engine->stack.size;
    while (engine->stack.size) {
      CHECK(naie_stack_pop(engine, &entry));
      if (entry.type == NAIG_STACK_CATCH) {
        engine->bytecode_pos = entry.address;
        engine->input_pos = entry.input_pos;
        engine->actions.size = entry.actioncount;
        goto NEXT;
      }
    }
    engine->actions.size = 0;
    result->code = -1;
    return NAIG_FAILURE;

NEXT: ;

  }
  RETURNERR(NAIE_ERR_CODEOVERFLOW);
}
