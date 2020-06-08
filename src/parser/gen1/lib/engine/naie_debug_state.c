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

#include <ctype.h>

#include "naie_private.h"

/**
 *
 */
void naie_debug_state
  (naie_engine_t* engine, int fullstack)
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
  for (i=0; i < engine->labelmap.size; i++) {
    if (engine->labelmap.entries[ i ].offset == engine->bytecode_pos) {
      fprintf(stderr, "                %s\n", engine->labelmap.entries[ i ].label);
    }
  }
  for (i=0; i < sizeof(copy); i++) {
    if (!isprint(copy[ i ])) { copy[ i ] = '.'; }
  }
  copy[ sizeof(copy) - 1 ] = 0;
  fprintf(stderr,
    "%13s @ %.6u txt: @ %.6u %s stk:"
    , naie_instr_string(opcode)
    , engine->bytecode_pos
    , engine->input_pos
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
  if (fullstack) {
    s = 0;
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
  if (fullstack) {
    naie_debug_actions(engine);
  }
}
