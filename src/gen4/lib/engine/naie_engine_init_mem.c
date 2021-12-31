/**
 * This file is part of Naigama, a parser engine.

Copyright (c) 2021, Kees-Jan Hermans <kees.jan.hermans@gmail.com>
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

#define TABLE_INIT_SIZE 32

/**
 * Initializer function for the engine structure, for embedded implementations
 * that work with fixed memory. This function allows you to specify all the
 * memories associated with a functioning Naigama engine.
 */
NAIG_ERR_T naie_engine_init_mem
  (
    naie_engine_t*        engine,
    const unsigned char*  bytecode,
    unsigned              bytecode_length,
    const unsigned char*  input,
    unsigned              input_length,
    void*                 mem_stack,
    unsigned              mem_stack_size,
    void*                 mem_actions,
    unsigned              mem_actions_size,
    void*                 mem_reg,
    unsigned              mem_reg_size
  )
{
  memset(engine, 0, sizeof(naie_engine_t));
  engine->bytecode = bytecode;
  engine->bytecode_length = bytecode_length;
  engine->input = input;
  engine->input_length = input_length;
  //engine->flags = NAIE_FLAG_ENDLESS;
  {
    engine->stack.realloc = 0;
    engine->stack.entries = mem_stack;
    engine->stack.length = mem_stack_size / sizeof(naie_stackentry_t);
  }
  {
    engine->actions.realloc = 0;
    engine->actions.entries = mem_actions;
    engine->actions.length = mem_actions_size / sizeof(naie_action_t);
  }
  {
    engine->reg.realloc = 0;
    engine->reg.entries = mem_reg;
    engine->reg.length = mem_reg_size / sizeof(naie_register_t);
  }
  return NAIG_OK;
}
