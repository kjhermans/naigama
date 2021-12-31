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

#include <stdlib.h>
#include <string.h>
#include <inttypes.h>

#include <naigama/naig_private.h>
#include "../../lib/engine/naie_private.h"

#include <naigama/naigama.h>
#include <naigama/engine/naie.h>
#include <naigama/util/util_functions.h>

static unsigned rec = 0;

static
char* naie_debug_action_string
  (unsigned action)
{
  switch (action) {
  case NAIG_ACTION_OPENCAPTURE:
    return "Co";
  case NAIG_ACTION_CLOSECAPTURE:
    return "Cc";
  case NAIG_ACTION_DELETE:
    return "Rx";
  case NAIG_ACTION_REPLACE_CHAR:
    return "Rc";
  case NAIG_ACTION_REPLACE_QUAD:
    return "Rq";
  default:
    return "!!";
  }
}

/**
 *
 */
NAIG_ERR_T engine_debug_report
  (naie_engine_t* engine, uint32_t opcode, void* arg)
{
  unsigned i;
  (void)arg;
  uint32_t param;

  fprintf(stdout, "\n==== Step %u\n", rec);
  switch (opcode) {
  case 0xffffffff:
    fprintf(stdout, "State: FAIL\n");
    break;
  default:
    fprintf(stdout, "State: Opcode execution\nOpcode: %s\n", naie_instr_string(opcode));
  }
  switch (opcode) {
  case OPCODE_CHAR:
    param = GET_32BIT_VALUE(engine->bytecode, engine->bytecode_pos + 4);
    fprintf(stdout, "Param1: 0x%.2x\n", param);
    break;
  case OPCODE_OPENCAPTURE:
  case OPCODE_CLOSECAPTURE:
  case OPCODE_END:
    param = GET_32BIT_VALUE(engine->bytecode, engine->bytecode_pos + 4);
    fprintf(stdout, "Param1: %u\n", param);
    break;
  case OPCODE_CALL:
  case OPCODE_CATCH:
  case OPCODE_PARTIALCOMMIT:
  case OPCODE_BACKCOMMIT:
  case OPCODE_JUMP:
    param = GET_32BIT_VALUE(engine->bytecode, engine->bytecode_pos + 4);
    fprintf(stdout, "Param1: %u ", param);
    fprintf(stdout, "%s\n", naie_labelmap_reverse(engine, param));
    break;
  }
  fprintf(stdout, "Bytecode pos: %u\n", engine->bytecode_pos);
  fprintf(stdout, "Input pos: %u\n", engine->input_pos);
  fprintf(stdout, "Input length: %u\n", engine->input_length);
  if (engine->input_pos < engine->input_length) {
    fprintf(stdout, "Input char: 0x%.2x\n", engine->input[ engine->input_pos ]);
  }
  fprintf(stdout, "Input string: ");
  for (i=0; i < 32; i++) {
    if (engine->input_pos + i < engine->input_length) {
      fprintf(stdout, "%.2x ", engine->input[ engine->input_pos + i ]);
    }
  }
  fprintf(stdout, "\n");
  fprintf(stdout, "Register_ilen: %u\n", engine->reg_ilen);
  fprintf(stdout, "Register_ilen_set: %d\n", engine->reg_ilen_set);
  fprintf(stdout, "Max stack depth: %u\n", engine->forensics.maxstackdepth);
  for (i=0; i < engine->labels.count; i++) {
    if (engine->labels.entries[ i ].offset == engine->bytecode_pos) {
      fprintf(stderr, "Label: %s\n", engine->labels.entries[ i ].label);
    }
  }
  fprintf(stdout, "Stack:\n");
  for (i=0; i < engine->stack.count; i++) {
    fprintf(stdout, "  %u; %s:%u "
      , i
      , ((engine->stack.entries[ i ].type == NAIG_STACK_CALL)
          ? "CLL" : "ALT")
      , engine->stack.entries[ i ].address
    );
    fprintf(stdout, "%s ", naie_labelmap_reverse(engine, GET_32BIT_VALUE(engine->bytecode, engine->stack.entries[ i ].address - 4)));
    if (engine->stack.entries[ i ].type == NAIG_STACK_CALL) {
      fprintf(stdout, "len=%u\n", engine->stack.entries[ i ].input_length);
    } else {
      fprintf(stdout, "pos=%u\n", engine->stack.entries[ i ].input_pos);
    }
  }
  fprintf(stdout, "Capturelist:\n");
  for (i=0; i < engine->actions.count; i++) {
    fprintf(stdout,
      "  Action #%u; act=%s, slot=%u, pos=%u, sl=%u, int=%"PRIu64" %s\n"
      , i
      , naie_debug_action_string(engine->actions.entries[ i ].action)
      , engine->actions.entries[ i ].slot
      , engine->actions.entries[ i ].inputpos
      , engine->actions.entries[ i ].stacklength
      , engine->actions.entries[ i ].intvalue
      , naio_slotmap_string(&(engine->slotmap), engine->actions.entries[ i ].slot)
    );
  }
  fprintf(stdout, "Registers:\n");
  for (i=0; i < engine->reg.length; i++) {
    if (engine->reg.entries[ i ].reg != 0) {
      fprintf(stdout, "  Reg %u: reg=%u, stcklen=%u, val=%u\n"
        , i
        , engine->reg.entries[ i ].reg
        , engine->reg.entries[ i ].stacklen
        , engine->reg.entries[ i ].value
      );
    }
  }
  fprintf(stdout, "\n");
  ++rec;
  return NAIG_OK;
}
