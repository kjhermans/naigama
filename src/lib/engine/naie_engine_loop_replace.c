/**
 * This file is part of Naigama, a parser engine.
 * Copyright 2020, KJ Hermans
 * Written by KJ Hermans <kees.jan.hermans@gmail.com>
 *
 * LICENSE:
 * Withheld
 *
 * \file
 * \brief
 */

#include <naigama/engine/naie.h>

NAIG_ERR_T naie_engine_loop_replace
  (
    naie_engine_t* engine,
    uint32_t slot
  )
{
  unsigned instruction_size;
  uint32_t quad;
  uint32_t opcode;
  uint32_t param1;
  unsigned char* value;
  unsigned valuesize;
  naie_action_t action;
  unsigned i;

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
      naie_debug_state(engine, 0);
    }
    switch (opcode) {

    case OPCODE_NOOP:
      engine->bytecode_pos += instruction_size;
      goto NEXT;

    case OPCODE_CHAR:
      action = (naie_action_t){
        .action = NAIG_ACTION_REPLACE_CHAR,
        .slot = slot,
        .intvalue = engine->bytecode[ engine->bytecode_pos + 7 ]
      };
      CHECK(naie_action_push(engine, action));
      engine->bytecode_pos += instruction_size;
      goto NEXT;

    case OPCODE_QUAD:
      memcpy(&quad, engine->bytecode + engine->bytecode_pos + 4, 4);
      action = (naie_action_t){
        .action = NAIG_ACTION_REPLACE_QUAD,
        .slot = slot,
        .intvalue = quad
      };
      CHECK(naie_action_push(engine, action));
      engine->bytecode_pos += instruction_size;
      goto NEXT;

    case OPCODE_VAR:
      param1 = GET_32BIT_NWO(engine->bytecode, engine->bytecode_pos + 4);
      CHECK(naie_variable(engine, engine->input, param1, &value, &valuesize));
      for (i=0; i + 4 < valuesize; i += 4) {
        memcpy(&quad, value + i, 4);
        action = (naie_action_t){
          .action = NAIG_ACTION_REPLACE_QUAD,
          .slot = slot,
          .intvalue = quad
        };
        CHECK(naie_action_push(engine, action));
      }
      for (; i < valuesize; i++) {
        action = (naie_action_t){
          .action = NAIG_ACTION_REPLACE_CHAR,
          .slot = slot,
          .intvalue = value[ i ]
        };
        CHECK(naie_action_push(engine, action));
      }
      engine->bytecode_pos += instruction_size;
      goto NEXT;

    case OPCODE_ENDREPLACE:
      engine->bytecode_pos += instruction_size;
      return NAIG_OK;

    default:
      RETURNERR(NAIE_ERR_BADOPCODE);
    }
NEXT: ;
  }
}
