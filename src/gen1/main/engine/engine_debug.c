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

#include <stdlib.h>
#include <string.h>

#include "../../lib/naigama/naig_private.h"
#include "../../lib/engine/naie_private.h"

#include <naigama/naigama.h>
#include <naigama/engine/naie.h>
#include <naigama/util/util_functions.h>

#define NAIG_DBGCMD_NEXT 0
#define NAIG_DBGCMD_QUIT 1
#define NAIG_DBGCMD_CONT 2
#define NAIG_DBGCMD_OVER 3
#define NAIG_DBGCMD_CALL 4

static
char debug_commands_grammar[] =
  " CMD <- ( \n"
  "          { 'next' / 'n' } / \n"
  "          { 'quit' / 'q' } / \n"
  "          { 'cont' / 'c' } / \n"
  "          { 'over' / 'o' } / \n"
  "          { 'help' / 'h' / '?' } / \n"
  "          { 'state' } / \n"
  "          { 'input' %s+ ( 'offset' %s+ { [0-9]+ } / \n"
  "                          'text' %s+ { .+ } ) } / \n"
  "          { 'instr' %s+ { [a-z]^-63 } } / \n"
  "          { 'label' %s+ { [a-zA-Z_][0-9a-zA-Z_]^-63 } } \n"
  "        ) !. \n";

static
naig_t debug_commands;

static
int debug_commands_init = 0;

//static
//unsigned lastcmd = 0;

extern NAIG_ERR_T engine_debug_instruction
  (naie_engine_t* engine, uint32_t opcode);

extern NAIG_ERR_T engine_debug_over
  (naie_engine_t* engine, uint32_t opcode);

extern NAIG_ERR_T engine_debug_inputoffset
  (naie_engine_t* engine, uint32_t opcode);

static
NAIG_ERR_T engine_debug_handler
  (naie_engine_t* engine, uint32_t opcode)
{
  char* cmdstr;
//  unsigned curcmd = lastcmd;
  naig_result_t cmd;

  if (!debug_commands_init) {
    memset(&debug_commands, 0, sizeof(debug_commands));
    naig_compile(&debug_commands, debug_commands_grammar);
    debug_commands_init = 1;
  }

BEGIN:
  if (opcode == 0xffffffff) {
    fprintf(stderr, "======== FAIL\n");
  } else {
    naie_debug_state(engine, 0);
  }
  switch (engine->debugstate) {
  case NAIE_DEBUG_FREE:
    return NAIG_OK;
  case NAIE_DEBUG_HALT:
    cmdstr = readline("naid > ");
    naig_run(&debug_commands, (unsigned char*)cmdstr, strlen(cmdstr), &cmd);
//naie_result_debug(&(cmd.result), (unsigned char*)cmdstr);
//naic_slotmap_debug(&(debug_commands.slotmap));

    if (cmd.result.count) {
      if (cmd.result.actions[ 0 ].slot ==
          naic_slotmap_query(&(debug_commands.slotmap), "CMD_NEXTN"))
      {
        fprintf(stderr, "Next.\n");
        return NAIG_OK;
      } else if (cmd.result.actions[ 0 ].slot ==
                 naic_slotmap_query(&(debug_commands.slotmap), "CMD_QUITQ"))
      {
        fprintf(stderr, "Quit.\n");
        exit(0);
      } else if (cmd.result.actions[ 0 ].slot ==
                 naic_slotmap_query(&(debug_commands.slotmap), "CMD_CONTC"))
      {
        fprintf(stderr, "Continue.\n");
        engine->debugstate = NAIE_DEBUG_FREE;
        return NAIG_OK;
      } else if (cmd.result.actions[ 0 ].slot ==
                 naic_slotmap_query(&(debug_commands.slotmap), "CMD_OVERO"))
      {
        fprintf(stderr, "Jumping over current calling context.\n");
        engine->debugstate = NAIE_DEBUG_FREE;
        engine->debugger = engine_debug_over;
        engine->debugoffset = engine->stack.count;;
        return NAIG_OK;
      } else if (cmd.result.actions[ 0 ].slot ==
                 naic_slotmap_query(&(debug_commands.slotmap), "CMD_HELPH"))
      {
        fprintf(stderr,
          "---- Flow following commands:\n"
          "next n            Jump to next instruction.\n"
          "cont c            Continue running.\n"
          "over o            Jump over function call.\n"
          "input text <text> Run to input text <text>\n"
          "input offset <n>  Run to input offset <n>\n"
          "instr <mnem>      Run to instruction <mnem>\n"
          "state             Output full state\n"
          "\n"
          "---- Flow upsetting commands:\n"
          "quit q            Stop execution.\n"
          "label <lab>       Jump to <lab>.\n"
          "call <lab>        Call <lab>.\n"
          "cancelfail        Cancel the current FAIL state.\n"
        );
        goto BEGIN;
      } else if (cmd.result.actions[ 0 ].slot ==
                 naic_slotmap_query(&(debug_commands.slotmap), "CMD_STATE"))
      {
        fprintf(stderr, "Showing engine state.\n");
        naie_debug_state(engine, 1);
        goto BEGIN;
      } else if (cmd.result.actions[ 0 ].slot ==
                 naic_slotmap_query(&(debug_commands.slotmap), "CMD_INPUTSOFFSETSTEXTS"))
      {
        char param[ 64 ];
        snprintf(param, sizeof(param), "%-.*s", cmd.result.actions[ 1 ].length, cmdstr + cmd.result.actions[ 1 ].start);
        if (cmd.result.actions[ 1 ].slot == cmd.result.actions[ 0 ].slot + 1) {
          engine->debugger = engine_debug_inputoffset;
          engine->debugoffset = atoi(param);
          engine->debugstate = NAIE_DEBUG_FREE;
          return NAIG_OK;
        } else if (cmd.result.actions[ 1 ].slot == cmd.result.actions[ 0 ].slot + 2) {
//..
        }
      } else if (cmd.result.actions[ 0 ].slot ==
                 naic_slotmap_query(&(debug_commands.slotmap), "CMD_INSTRSAZ"))
      {
        char param[ 64 ];
        snprintf(param, sizeof(param), "%-.*s", cmd.result.actions[ 1 ].length, cmdstr + cmd.result.actions[ 1 ].start);
        if (0 == strcmp(param, "call")) {
          fprintf(stderr, "Running up to the next 'call' instruction.\n");
          engine->debugger = engine_debug_instruction;
          engine->debugoffset = OPCODE_CALL;
          engine->debugstate = NAIE_DEBUG_FREE;
          return NAIG_OK;
        }
      }
    } else if (!strlen(cmdstr)) {
      fprintf(stderr, "Next.\n");
      return NAIG_OK;
    }

    free(cmdstr);
    break;
  }
  return NAIG_OK;
}

/**
 *
 */
NAIG_ERR_T engine_debug_bytecode
  (naie_engine_t* engine, uint32_t opcode)
{
  if (engine->debugstate == NAIE_DEBUG_FREE
      && engine->bytecode_pos == engine->debugoffset)
  {
    fprintf(stdout, "Break point reached because bytecode offset = %u.\n"
      , engine->bytecode_pos
    );
    engine->debugstate = NAIE_DEBUG_HALT;
  }
  return engine_debug_handler(engine, opcode);
}

/**
 *
 */
NAIG_ERR_T engine_debug_instruction
  (naie_engine_t* engine, uint32_t opcode)
{
  if (engine->debugstate == NAIE_DEBUG_FREE
      && opcode == engine->debugoffset)
  {
    fprintf(stdout, "Break point reached because opcode = %.8x.\n"
      , engine->debugoffset
    );
    engine->debugstate = NAIE_DEBUG_HALT;
  }
  return engine_debug_handler(engine, opcode);
}

/**
 *
 */
NAIG_ERR_T engine_debug_inputtext
  (naie_engine_t* engine, uint32_t opcode)
{
  char* t = engine->debugtext;
  unsigned l = strlen(t);

  if (engine->debugstate == NAIE_DEBUG_FREE
      && engine->input_pos < engine->input_length - l
      && 0 == memcmp(engine->input + engine->input_pos, t, l))
  {
    fprintf(stdout, "Break point reached because input text is '%s'.\n"
      , t
    );
    engine->debugstate = NAIE_DEBUG_HALT;
  }
  return engine_debug_handler(engine, opcode);
}

/**
 *
 */
NAIG_ERR_T engine_debug_over
  (naie_engine_t* engine, uint32_t opcode)
{
  if (engine->debugstate == NAIE_DEBUG_FREE
      && engine->stack.count < engine->debugoffset)
  {
    fprintf(stdout, "Break point reached because stack size < %u.\n"
      , engine->debugoffset
    );
    engine->debugstate = NAIE_DEBUG_HALT;
  }
  return engine_debug_handler(engine, opcode);
}

/**
 *
 */
NAIG_ERR_T engine_debug_inputoffset
  (naie_engine_t* engine, uint32_t opcode)
{
  if (engine->debugstate == NAIE_DEBUG_FREE
      && engine->input_pos == engine->debugoffset)
  {
    fprintf(stdout, "Break point reached because input offset = %u.\n"
      , engine->input_pos
    );
    engine->debugstate = NAIE_DEBUG_HALT;
  }
  return engine_debug_handler(engine, opcode);
}
