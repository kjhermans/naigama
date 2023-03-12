/**
 * This file is part of Oroszlan, a parsing and scripting environment

Copyright (c) 2023, Kees-Jan Hermans <kees.jan.hermans@gmail.com>
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

#include <naigama/assembler/naig_slotmap_assembly.h>
#include <naigama/naigama/naig_instructions.h>

/**
 *
 */
NAIG_ERR_T naia_slot2opcode
  (unsigned slot, uint32_t* opcode)
{
  switch (slot) {
  case SLOTMAP_ANYINSTR_ANY:
    *opcode = OPCODE_ANY;
    break;
  case SLOTMAP_BACKCOMMITINSTR_BACKCOMMIT:
    *opcode = OPCODE_BACKCOMMIT;
    break;
  case SLOTMAP_CALLINSTR_CALL:
    *opcode = OPCODE_CALL;
    break;
  case SLOTMAP_CATCHINSTR_CATCH:
    *opcode = OPCODE_CATCH;
    break;
  case SLOTMAP_CHARINSTR_CHAR:
    *opcode = OPCODE_CHAR;
    break;
  case SLOTMAP_MASKEDCHARINSTR_MASKEDCHAR:
    *opcode = OPCODE_MASKEDCHAR;
    break;
  case SLOTMAP_CLOSECAPTUREINSTR_CLOSECAPTURE:
    *opcode = OPCODE_CLOSECAPTURE;
    break;
  case SLOTMAP_COMMITINSTR_COMMIT:
    *opcode = OPCODE_COMMIT;
    break;
  case SLOTMAP_ENDINSTR_END:
    *opcode = OPCODE_END;
    break;
  case SLOTMAP_FAILINSTR_FAIL:
    *opcode = OPCODE_FAIL;
    break;
  case SLOTMAP_FAILTWICEINSTR_FAILTWICE:
    *opcode = OPCODE_FAILTWICE;
    break;
  case SLOTMAP_JUMPINSTR_JUMP:
    *opcode = OPCODE_JUMP;
    break;
  case SLOTMAP_NOOPINSTR_NOOP:
    *opcode = OPCODE_NOOP;
    break;
  case SLOTMAP_TRAPINSTR_TRAP:
    *opcode = OPCODE_TRAP;
    break;
  case SLOTMAP_OPENCAPTUREINSTR_OPENCAPTURE:
    *opcode = OPCODE_OPENCAPTURE;
    break;
  case SLOTMAP_INTRPCAPTUREINSTR_INTRPCAPTURE:
    *opcode = OPCODE_INTRPCAPTURE;
    break;
  case SLOTMAP_PARTIALCOMMITINSTR_PARTIALCOMMIT:
    *opcode = OPCODE_PARTIALCOMMIT;
    break;
  case SLOTMAP_QUADINSTR_QUAD:
    *opcode = OPCODE_QUAD;
    break;
  case SLOTMAP_RANGEINSTR_RANGE:
    *opcode = OPCODE_RANGE;
    break;
  case SLOTMAP_REPLACEINSTR_REPLACE:
    *opcode = OPCODE_REPLACE;
    break;
  case SLOTMAP_ENDREPLACEINSTR_ENDREPLACE:
    *opcode = OPCODE_ENDREPLACE;
    break;
  case SLOTMAP_RETINSTR_RET:
    *opcode = OPCODE_RET;
    break;
  case SLOTMAP_SETINSTR_SET:
    *opcode = OPCODE_SET;
    break;
  case SLOTMAP_SKIPINSTR_SKIP:
    *opcode = OPCODE_SKIP;
    break;
  case SLOTMAP_SPANINSTR_SPAN:
    *opcode = OPCODE_SPAN;
    break;
  case SLOTMAP_TESTANYINSTR_TESTANY:
    *opcode = OPCODE_TESTANY;
    break;
  case SLOTMAP_TESTCHARINSTR_TESTCHAR:
    *opcode = OPCODE_TESTCHAR;
    break;
  case SLOTMAP_TESTSETINSTR_TESTSET:
    *opcode = OPCODE_TESTSET;
    break;
  case SLOTMAP_VARINSTR_VAR:
    *opcode = OPCODE_VAR;
    break;
  case SLOTMAP_COUNTERINSTR_COUNTER:
    *opcode = OPCODE_COUNTER;
    break;
  case SLOTMAP_CONDJUMPINSTR_CONDJUMP:
    *opcode = OPCODE_CONDJUMP;
    break;
  case SLOTMAP_ISOLATEINSTR_ISOLATE:
    *opcode = OPCODE_ISOLATE;
    break;
  case SLOTMAP_ENDISOLATEINSTR_ENDISOLATE:
    *opcode = OPCODE_ENDISOLATE;
    break;
  default:
    RETURNERR(NAIG_ERR_INTEGRITY);
  }
  return NAIG_OK;
}
