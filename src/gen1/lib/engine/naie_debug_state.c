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

#include <ctype.h>

#include "naie_private.h"

/**
 * Prints to stderr the current state of the engine.
 */
void naie_debug_state
  (naie_engine_t* engine, int full)
{
  char copy[ 9 ];
  unsigned i;
  uint32_t opcode =GET_32BIT_NWO(engine->bytecode, engine->bytecode_pos);

  memset(copy, 0, sizeof(copy));
  memcpy(
    copy,
    engine->input + engine->input_pos,
    (sizeof(copy) < engine->input_length - engine->input_pos)
      ? sizeof(copy)
      : engine->input_length - engine->input_pos
  );
  for (i=0; i < engine->labels.count; i++) {
    if (engine->labels.entries[ i ].offset == engine->bytecode_pos) {
      fprintf(stderr, "                %s\n", engine->labels.entries[ i ].label);
    }
  }
  for (i=0; i < sizeof(copy); i++) {
    if (!isprint(copy[ i ])) { copy[ i ] = '.'; }
  }
  copy[ sizeof(copy) - 1 ] = 0;
  if (full) {
    naie_debug_instruction(engine);
  }
  fprintf(stderr,
    "%13s @ %.6u txt: @ %.6u %s stk:"
    , naie_instr_string(opcode)
    , engine->bytecode_pos
    , engine->input_pos
    , copy
  );
  unsigned s = 0;
  for (i=0; i < engine->stack.count; i++) {
    if (engine->stack.entries[ i ].type == NAIG_STACK_CATCH) {
      s = i;
    }
  }
  if (s && s > engine->stack.count - 8) {
    s = engine->stack.count - 8;
  }
  if (full) {
    s = 0;
    fprintf(stderr, "\n");
  } else {
    fprintf(stderr, "(%.3u prec.) ", s);
  }
  for (i=s; i < engine->stack.count; i++) {
    fprintf(stderr, "%s:%u "
      , ((engine->stack.entries[ i ].type == NAIG_STACK_CALL)
          ? "CLL" : "ALT")
      , engine->stack.entries[ i ].address
    );
    if (full) {
      if (engine->stack.entries[ i ].type == NAIG_STACK_CALL) {
        fprintf(stderr, "%s\n", naie_labelmap_reverse(engine, GET_32BIT_NWO(engine->bytecode, engine->stack.entries[ i ].address - 4)));
      } else {
        fprintf(stderr, "%s\n", naie_labelmap_reverse(engine, engine->stack.entries[ i ].address));
      }
    }
  }
  fprintf(stderr, "\n");
  if (full) {
    naie_debug_actions(engine);
  }
}
