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
 * Performs the replacement bytecode (which only pushes actions on the
 * action list). Actual replacement is done by the action processor.
 */
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

  if ((i = engine->actions.count) < 2) {
    RETURNERR(NAIG_ERR_ACTIONLIST);
  }
  --i;
  if (engine->actions.entries[ i ].action != NAIG_ACTION_CLOSECAPTURE
      || engine->actions.entries[ i ].slot != slot)
  {
    RETURNERR(NAIG_ERR_ACTIONLIST);
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
      RETURNERR(NAIG_ERR_ACTIONLIST);
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
      naie_debug_state(engine, 0, 0);
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
      param1 = GET_32BIT_VALUE(engine->bytecode, engine->bytecode_pos + 4);
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
      RETURNERR(NAIG_ERR_BADOPCODE);
    }
NEXT: ;
  }
}
