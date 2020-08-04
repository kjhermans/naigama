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

#include <naigama/engine/naie.h>
#include <naigama/util/util_functions.h>

#define NAIG_DBGCMD_NEXT 0
#define NAIG_DBGCMD_QUIT 1
#define NAIG_DBGCMD_CONT 2
#define NAIG_DBGCMD_OVER 3
#define NAIG_DBGCMD_CALL 4

static
unsigned lastcmd = 0;

static
NAIG_ERR_T engine_debug_handler
  (naie_engine_t* engine, uint32_t opcode)
{
  char* cmdstr;
  unsigned curcmd = lastcmd;

BEGIN:
  switch (engine->debugstate) {
  case NAIE_DEBUG_FREE:
    return NAIG_OK;
  case NAIE_DEBUG_HALT:
    cmdstr = readline("naid > ");
    if (0 == strcmp(cmdstr, "q") || 0 == strcmp(cmdstr, "quit")) {
      curcmd = NAIG_DBGCMD_QUIT;
    } else if (0 == strcmp(cmdstr, "c") || 0 == strcmp(cmdstr, "cont")) {
      curcmd = NAIG_DBGCMD_CONT;
    } else if (0 == strcmp(cmdstr, "over")) {
      curcmd = NAIG_DBGCMD_OVER;
    } else if (0 == strcmp(cmdstr, "call")) {
      curcmd = NAIG_DBGCMD_CALL;
    } else if (0 == strcmp(cmdstr, "?")
               || 0 == strcmp(cmdstr, "h")
               || 0 == strcmp(cmdstr, "help"))
    {
      fprintf(stderr,
        "Commands:\n"
        "next            Jump to next instruction.\n"
        "quit q          Stop execution.\n"
        "cont c          Continue running.\n"
        "over            Jump over function call.\n"
        "call            Continue to next CALL instruction.\n"
      );
      goto BEGIN;
    } else if (*cmdstr) {
      fprintf(stderr, "Unknown command. Assuming 'next'\n");
      curcmd = NAIG_DBGCMD_NEXT;
    }
    lastcmd = curcmd;
    free(cmdstr);
    switch (curcmd) {
    case NAIG_DBGCMD_NEXT:
      fprintf(stderr, "Next.\n");
      return NAIG_OK;
    case NAIG_DBGCMD_QUIT:
      fprintf(stderr, "Quit.\n");
      exit(0);
    case NAIG_DBGCMD_CONT:
      fprintf(stderr, "Continue.\n");
      engine->debugstate = NAIE_DEBUG_FREE;
      break;
    case NAIG_DBGCMD_OVER:
      fprintf(stderr, "Jump over.\n");
      if (opcode == OPCODE_CALL) {
        //.. set state to something waiting for RET
      } else {
        fprintf(stderr, "Require a call instruction for stepping over.\n");
      }
      break;
    case NAIG_DBGCMD_CALL:
      fprintf(stderr, "Continue to CALL.\n");
      engine->debugstate = NAIE_DEBUG_CALL;
      break;
    }
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
  switch (engine->debugstate) {
  case NAIE_DEBUG_FREE:
    if (engine->bytecode_pos == engine->debugoffset) {
      fprintf(stdout, "Break point reached because bytecode offset = %u.\n"
        , engine->bytecode_pos
      );
      engine->debugstate = NAIE_DEBUG_HALT;
    }
    break;
  }
  return engine_debug_handler(engine, opcode);
}

/**
 *
 */
NAIG_ERR_T engine_debug_inputtext
  (naie_engine_t* engine, uint32_t opcode)
{
}

/**
 *
 */
NAIG_ERR_T engine_debug_inputoffset
  (naie_engine_t* engine, uint32_t opcode)
{
  switch (engine->debugstate) {
  case NAIE_DEBUG_FREE:
    if (engine->input_pos == engine->debugoffset) {
      fprintf(stdout, "Break point reached because input offset = %u.\n"
        , engine->input_pos
      );
      engine->debugstate = NAIE_DEBUG_HALT;
    }
    break;
  case NAIE_DEBUG_CALL:
    if (opcode == OPCODE_CALL) {
      fprintf(stdout, "Break point reached because opcode == CALL.\n");
      engine->debugstate = NAIE_DEBUG_HALT;
    }
    break;
  }
  return engine_debug_handler(engine, opcode);
}
