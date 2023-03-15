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
 * Instruction handler of the assembler second pass.
 * Switches to the instruction type and calls sub-handlers to
 * create the binary bytecode.
 *
 * \param naia  Initialized assembler structure.
 * \param obj   Parse node.
 * \returns     NAIG_OK on success, and a NAIG_ERR_T code on failure.
 */
NAIG_ERR_T naia_sp_instruction
  (naia_t* naia, naig_resobj_t* obj)
{
  DEBUGFUNCTION;
  ASSERT(naia);
  ASSERT(obj);

  uint32_t opcode;

  NAIG_CHECK(naia_slot2opcode(obj->children[ 0 ]->type, &opcode), PROPAGATE);
  switch (obj->children[ 0 ]->type) {
  case SLOTMAP_ANYINSTR_ANY:
  case SLOTMAP_FAILINSTR_FAIL:
  case SLOTMAP_FAILTWICEINSTR_FAILTWICE:
  case SLOTMAP_RETINSTR_RET:
  case SLOTMAP_NOOPINSTR_NOOP:
  case SLOTMAP_TRAPINSTR_TRAP:
  case SLOTMAP_ENDREPLACEINSTR_ENDREPLACE:
  case SLOTMAP_ENDISOLATEINSTR_ENDISOLATE:
    NAIG_CHECK(naia_sp_instruction_single(naia, opcode), PROPAGATE);
    break;
  case SLOTMAP_CALLINSTR_CALL:
  case SLOTMAP_JUMPINSTR_JUMP:
  case SLOTMAP_CATCHINSTR_CATCH:
  case SLOTMAP_COMMITINSTR_COMMIT:
  case SLOTMAP_BACKCOMMITINSTR_BACKCOMMIT:
  case SLOTMAP_PARTIALCOMMITINSTR_PARTIALCOMMIT:
  case SLOTMAP_TESTANYINSTR_TESTANY:
    NAIG_CHECK(
      naia_sp_instruction_double_labeled(
        naia,
        opcode,
        obj->children[ 1 ]->string
      ),
      PROPAGATE
    );
    break;
  case SLOTMAP_ENDINSTR_END:
  case SLOTMAP_OPENCAPTUREINSTR_OPENCAPTURE:
  case SLOTMAP_CLOSECAPTUREINSTR_CLOSECAPTURE:
  case SLOTMAP_SKIPINSTR_SKIP:
  case SLOTMAP_VARINSTR_VAR:
  case SLOTMAP_ISOLATEINSTR_ISOLATE:
    NAIG_CHECK(
      naia_sp_instruction_double_decimal(
        naia,
        opcode,
        obj->children[ 1 ]->string
      ),
      PROPAGATE
    );
    break;
  case SLOTMAP_CHARINSTR_CHAR:
    NAIG_CHECK(
      naia_sp_instruction_char(
        naia,
        obj->children[ 1 ]->string
      ),
      PROPAGATE
    );
    break;
  case SLOTMAP_MASKEDCHARINSTR_MASKEDCHAR:
    NAIG_CHECK(
      naia_sp_instruction_maskedchar(
        naia,
        obj->children[ 1 ]->string,
        obj->children[ 2 ]->string
      ),
      PROPAGATE
    );
    break;
  case SLOTMAP_INTRPCAPTUREINSTR_INTRPCAPTURE:
    break;
  case SLOTMAP_QUADINSTR_QUAD:
    NAIG_CHECK(
      naia_sp_instruction_quad(
        naia,
        obj->children[ 1 ]->string
      ),
      PROPAGATE
    );
    break;
  case SLOTMAP_RANGEINSTR_RANGE:
    NAIG_CHECK(
      naia_sp_instruction_triple_decimal(
        naia,
        OPCODE_RANGE,
        obj->children[ 1 ]->string,
        obj->children[ 2 ]->string
      ),
      PROPAGATE
    );
    break;
  case SLOTMAP_SETINSTR_SET:
  case SLOTMAP_SPANINSTR_SPAN:
    NAIG_CHECK(
      naia_sp_instruction_set(
        naia,
        opcode,
        obj->children[ 1 ]->string
      ),
      PROPAGATE
    );
    break;
  case SLOTMAP_TESTCHARINSTR_TESTCHAR:
    break;
  case SLOTMAP_TESTSETINSTR_TESTSET:
    break;
  case SLOTMAP_COUNTERINSTR_COUNTER:
    NAIG_CHECK(
      naia_sp_instruction_triple_decimal(
        naia,
        OPCODE_COUNTER,
        obj->children[ 1 ]->string,
        obj->children[ 2 ]->string
      ),
      PROPAGATE
    );
    break;
  case SLOTMAP_REPLACEINSTR_REPLACE:
  case SLOTMAP_CONDJUMPINSTR_CONDJUMP:
    NAIG_CHECK(
      naia_sp_instruction_triple_decimal_label(
        naia,
        opcode,
        obj->children[ 1 ]->string,
        obj->children[ 2 ]->string
      ),
      PROPAGATE
    );
    break;
  }
  naia->offset += NAIA_INSTR_SIZE(opcode);
  return NAIG_OK;
}
