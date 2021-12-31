/**
 * This file is part of Oroszlan, a parsing and scripting environment

Copyright (c) 2021, Kees-Jan Hermans <kees.jan.hermans@gmail.com>
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the organization nor the
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

#include "naia_private.h"

/**
 *
 */
uint32_t naia_instruction_opcode
  (naio_resobj_t* object)
{
  switch (object->children[ 0 ]->type) {
  case ASMSLOT_ANYINSTR_ANY: return OPCODE_ANY;
  case ASMSLOT_BACKCOMMITINSTR_BACKCOMMIT: return OPCODE_BACKCOMMIT;
  case ASMSLOT_CALLINSTR_CALL: return OPCODE_CALL;
  case ASMSLOT_CATCHINSTR_CATCH: return OPCODE_CATCH;
  case ASMSLOT_CHARINSTR_CHAR: return OPCODE_CHAR;
  case ASMSLOT_MASKEDCHARINSTR_MASKEDCHAR: return OPCODE_MASKEDCHAR;
  case ASMSLOT_CLOSECAPTUREINSTR_CLOSECAPTURE: return OPCODE_CLOSECAPTURE;
  case ASMSLOT_COMMITINSTR_COMMIT: return OPCODE_COMMIT;
  case ASMSLOT_ENDINSTR_END: return OPCODE_END;
  case ASMSLOT_FAILINSTR_FAIL: return OPCODE_FAIL;
  case ASMSLOT_FAILTWICEINSTR_FAILTWICE: return OPCODE_FAILTWICE;
  case ASMSLOT_INTRPCAPTUREINSTR_INTRPCAPTURE: return OPCODE_INTRPCAPTURE;
  case ASMSLOT_JUMPINSTR_JUMP: return OPCODE_JUMP;
  case ASMSLOT_NOOPINSTR_NOOP: return OPCODE_NOOP;
  case ASMSLOT_TRAPINSTR_TRAP: return OPCODE_TRAP;
  case ASMSLOT_OPENCAPTUREINSTR_OPENCAPTURE: return OPCODE_OPENCAPTURE;
  case ASMSLOT_PARTIALCOMMITINSTR_PARTIALCOMMIT: return OPCODE_PARTIALCOMMIT;
  case ASMSLOT_QUADINSTR_QUAD: return OPCODE_QUAD;
  case ASMSLOT_REPLACEINSTR_REPLACE: return OPCODE_REPLACE;
  case ASMSLOT_ENDREPLACEINSTR_ENDREPLACE: return OPCODE_ENDREPLACE;
  case ASMSLOT_RETINSTR_RET: return OPCODE_RET;
  case ASMSLOT_SETINSTR_SET: return OPCODE_SET;
  case ASMSLOT_RANGEINSTR_RANGE: return OPCODE_RANGE;
  case ASMSLOT_SKIPINSTR_SKIP: return OPCODE_SKIP;
  case ASMSLOT_SPANINSTR_SPAN: return OPCODE_SPAN;
  case ASMSLOT_TESTANYINSTR_TESTANY: return OPCODE_TESTANY;
  case ASMSLOT_TESTCHARINSTR_TESTCHAR: return OPCODE_TESTCHAR;
  case ASMSLOT_TESTQUADINSTR_TESTQUAD: return OPCODE_TESTQUAD;
  case ASMSLOT_TESTSETINSTR_TESTSET: return OPCODE_TESTSET;
  case ASMSLOT_VARINSTR_VAR: return OPCODE_VAR;
  case ASMSLOT_COUNTERINSTR_COUNTER: return OPCODE_COUNTER;
  case ASMSLOT_CONDJUMPINSTR_CONDJUMP: return OPCODE_CONDJUMP;
  case ASMSLOT_ISOLATEINSTR_ISOLATE: return OPCODE_ISOLATE;
  case ASMSLOT_ENDISOLATEINSTR_ENDISOLATE: return OPCODE_ENDISOLATE;
  case ASMSLOT_MODEINSTR_MODE: return OPCODE_MODE;

  default:
    fprintf(stderr, "Unknown instruction.\n");
    naio_resobj_debug(object, 0);
  }
  return 0;
}

unsigned naia_instruction_length
  (naio_resobj_t* object)
{
  uint32_t opcode = naia_instruction_opcode(object);

  return ((opcode >> 16) & 0xff) + 4;
}
