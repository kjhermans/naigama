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
  unsigned i, region_start, region_stop;

  if ((i = engine->actions.size) < 2) {
    RETURNERR(NAIE_ERR_ACTIONLIST);
  }
  --i;
  if (engine->actions.entries[ i ].action != NAIG_ACTION_CLOSECAPTURE
      || engine->actions.entries[ i ].slot != slot)
  {
    RETURNERR(NAIE_ERR_ACTIONLIST);
  } else {
    region_stop = engine->actions.entries[ i ].inputpos;
  }
  --i;
  while (1) {
    if (engine->actions.entries[ i ].action == NAIG_ACTION_OPENCAPTURE
        && engine->actions.entries[ i ].slot == slot)
    {
      region_start = engine->actions.entries[ i ].inputpos;
      break;
    }
    if (i == 0) {
      RETURNERR(NAIE_ERR_ACTIONLIST);
    }
    --i;
  }
  action = (naie_action_t){
    .action = NAIG_ACTION_DELETE,
    .slot = slot,
    .inputpos = region_start,
    .intvalue = region_stop - region_start
  };
  CHECK(naie_action_push(engine, action));

  while (1) {
    if (engine->bytecode_pos > engine->bytecode_length - 4) {
      RETURNERR(NAIE_ERR_CODEOVERFLOW);
    }
    opcode = GET_32BIT_NWO(engine->bytecode, engine->bytecode_pos);
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
      ++(engine->noinstructions);
      if (engine->stack.size > engine->maxstackdepth) {
        engine->maxstackdepth = engine->stack.size;
      }
    }
    if (engine->flags & NAIE_FLAG_DEBUG) {
      naie_debug_state(engine, 0);
//      naie_debug_actions(engine);
    }
    switch (opcode) {

    case OPCODE_NOOP:
      engine->bytecode_pos += instruction_size;
      goto NEXT;

    case OPCODE_CHAR:
      action = (naie_action_t){
        .action = NAIG_ACTION_REPLACE_CHAR,
        .slot = slot,
        .intvalue = engine->bytecode[ engine->bytecode_pos + 7 ],
        .inputpos = engine->input_pos
      };
      CHECK(naie_action_push(engine, action));
      engine->bytecode_pos += instruction_size;
      goto NEXT;

    case OPCODE_QUAD:
      memcpy(&quad, engine->bytecode + engine->bytecode_pos + 4, 4);
      action = (naie_action_t){
        .action = NAIG_ACTION_REPLACE_QUAD,
        .slot = slot,
        .intvalue = quad,
        .inputpos = engine->input_pos
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
          .intvalue = quad,
          .inputpos = engine->input_pos
        };
        CHECK(naie_action_push(engine, action));
      }
      for (; i < valuesize; i++) {
        action = (naie_action_t){
          .action = NAIG_ACTION_REPLACE_CHAR,
          .slot = slot,
          .intvalue = value[ i ],
          .inputpos = engine->input_pos
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
