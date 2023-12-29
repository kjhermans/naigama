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

#include <naigama/naig_private.h>
#include "../../lib/engine/naie_private.h"

#include <naigama/naigama.h>
#include <naigama/engine/naie.h>
#include <naigama/util/util_functions.h>

struct edbfstruct
{
  char* path;
};

//static struct edbfstruct edbf = { 0 };

static
NAIG_ERR_T engine_debug_fuzz_alt_char
  (int fail, uint32_t chr)
{
  (void)fail;
  (void)chr;

  return NAIG_OK;
}

static
NAIG_ERR_T engine_debug_fuzz_alt_end
  ()
{
  return NAIG_OK;
}

/**
 *
 */
NAIG_ERR_T engine_debug_fuzz
  (naie_engine_t* engine, uint32_t opcode, void* arg)
{
  uint32_t param1;
  (void)arg;

  switch (opcode) {
  case OPCODE_ANY:
    NAIG_CHECK(engine_debug_fuzz_alt_char(0, rand() % 256));
    NAIG_CHECK(engine_debug_fuzz_alt_end());
    break;
  case OPCODE_COUNTER:
    break;
  case OPCODE_CHAR:
    param1 = GET_32BIT_VALUE(engine->bytecode, engine->bytecode_pos + 4);
    NAIG_CHECK(engine_debug_fuzz_alt_char(0, param1));
    NAIG_CHECK(engine_debug_fuzz_alt_char(1, (param1 ^ param1) & 0xff));
    NAIG_CHECK(engine_debug_fuzz_alt_end());
    break;
  case OPCODE_MASKEDCHAR:
    break;
  case OPCODE_QUAD:
    break;
  case OPCODE_RANGE:
    break;
  case OPCODE_SET:
    break;
  case OPCODE_SKIP:
    break;
  case OPCODE_SPAN:
    break;
  case OPCODE_TESTANY:
    break;
  case OPCODE_TESTCHAR:
    break;
  case OPCODE_TESTQUAD:
    break;
  case OPCODE_TESTSET:
    break;
  case OPCODE_BACKCOMMIT:
  case OPCODE_CALL:
  case OPCODE_CATCH:
  case OPCODE_CLOSECAPTURE:
  case OPCODE_COMMIT:
  case OPCODE_CONDJUMP:
  case OPCODE_END:
  case OPCODE_ENDREPLACE:
  case OPCODE_FAIL:
  case OPCODE_FAILTWICE:
  case OPCODE_JUMP:
  case OPCODE_NOOP:
  case OPCODE_OPENCAPTURE:
  case OPCODE_PARTIALCOMMIT:
  case OPCODE_REPLACE:
  case OPCODE_RET:
  case OPCODE_TRAP:
  case OPCODE_VAR:
    break;
  }
  return NAIG_OK;
}
