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

#include <math.h>
#include <ctype.h>

#include "naie_private.h"

static
NAIG_ERR_T _naie_debug_state
  (naie_engine_t* engine, int full, int hex)
{
  char copy[ 32 ];
  unsigned i;
  uint32_t opcode = GET_32BIT_VALUE(engine->bytecode, engine->bytecode_pos);
  unsigned magn_byc = log10(engine->bytecode_length) + 1;
  unsigned magn_inp = log10(engine->input_length) + 1;

  memset(copy, 0, sizeof(copy));
  for (i=0; i < 8; i++) {
    if (engine->input_pos + i < engine->input_length) {
      unsigned char c = engine->input[ engine->input_pos + i ];
      if (hex) {
        sprintf(copy + (i * 2), "%.2x", c);
      } else {
        if (isprint(c)) {
          copy[ i ] = c;
        } else {
          copy[ i ] = '.';
        }
      }
    } else {
      if (hex) {
        copy[ i * 2 ] = '_';
        copy[ i * 2 + 1 ] = '_';
      } else {
        copy[ i ] = '*';
      }
    }
  }
  for (i=0; i < engine->labelmap.count; i++) {
    if (engine->labelmap.entries[ i ].offset == engine->bytecode_pos) {
      fprintf(stderr, "            %-.*s:\n"
        , engine->labelmap.entries[ i ].len
        , engine->labelmap.entries[ i ].str
      );
    }
  }
  fprintf(stderr, "%.6u ", engine->forensics.noinstructions);
  if (full) {
    naie_debug_instruction(engine);
  }
  fprintf(stderr,
    "%13s bc %-.*u in %-.*u %s st "
    , naie_instr_string(opcode)
    , magn_byc
    , engine->bytecode_pos
    , magn_inp
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
        fprintf(stderr, "%s\n",
          naio_labelmap_reverse(
            &(engine->labelmap),
            GET_32BIT_VALUE(
              engine->bytecode,
              engine->stack.entries[ i ].address - 4
            )
          )
        );
      } else {
        fprintf(stderr, "%s\n",
          naio_labelmap_reverse(
            &(engine->labelmap), engine->stack.entries[ i ].address
          )
        );
      }
    }
  }
  fprintf(stderr, "\n");
  if (full) {
    naie_debug_actions(engine);
  }
  return NAIG_OK;
}

/**
 * Prints to stderr the current state of the engine.
 */
void naie_debug_state
  (naie_engine_t* engine, int full, int hex)
{
  NAIG_ERR_T e = _naie_debug_state(engine, full, hex);
  (void)e;
}

