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

static
NAIG_ERR_T _naie_debug_instruction
  (naie_engine_t* engine)
{
  uint32_t opcode, param1; //, param2;
  char* label;

  opcode = GET_32BIT_VALUE(engine->bytecode, engine->bytecode_pos);
  switch (opcode) {
  case OPCODE_CALL:
    param1 = GET_32BIT_VALUE(engine->bytecode, engine->bytecode_pos + 4);
    label = naio_labelmap_reverse(&(engine->labelmap), param1);
    fprintf(stderr, "CALL %u %s\n", param1, (label ? label : ""));
    break;
  }
  return NAIG_OK;
}

/**
 * Debugs the current instruction (more verbosely than the normal
 * debugging function does.
 */
void naie_debug_instruction
  (naie_engine_t* engine)
{
  NAIG_ERR_T e = _naie_debug_instruction(engine);
  (void)e;
}
