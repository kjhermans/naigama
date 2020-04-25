/**
 * This file is part of Raksaka / NAIG,
 * which is a network guard / message parser solution.
 * Copyright 2020, KJ Hermans
 * Written by KJ Hermans <kees.jan.hermans@gmail.com>
 *
 * LICENSE:
 * Withheld
 *
 * \file
 * \brief
 */

#include <naigama/assembler/naia.h>

/**
 * Topmost function
 */
NAIG_ERR_T naia_process_labels
  (naia_t* naia)
{
  unsigned i, offset = 0;

  for (i=0; i < naia->captures->size; i++) {
    switch (naia->captures->actions[ i ].slot) {
    case ASMSLOT_ANYINSTR_ANY:
      offset += NAIG_INSTR_LENGTH(OPCODE_ANY);
      break;
    case ASMSLOT_BACKCOMMITINSTR_BACKCOMMIT:
      offset += NAIG_INSTR_LENGTH(OPCODE_BACKCOMMIT);
      break;
    case ASMSLOT_CALLINSTR_CALL:
      offset += NAIG_INSTR_LENGTH(OPCODE_CALL);
      break;
    case ASMSLOT_CATCHINSTR_CATCH:
      offset += NAIG_INSTR_LENGTH(OPCODE_CATCH);
      break;
    case ASMSLOT_CHARINSTR_CHAR:
      offset += NAIG_INSTR_LENGTH(OPCODE_CHAR);
      break;
    case ASMSLOT_CLOSECAPTUREINSTR_CLOSECAPTURE:
      offset += NAIG_INSTR_LENGTH(OPCODE_CLOSECAPTURE);
      break;
    case ASMSLOT_COMMITINSTR_COMMIT:
      offset += NAIG_INSTR_LENGTH(OPCODE_COMMIT);
      break;
    case ASMSLOT_ENDINSTR_END:
      offset += NAIG_INSTR_LENGTH(OPCODE_END);
      break;
    case ASMSLOT_FAILINSTR_FAIL:
      offset += NAIG_INSTR_LENGTH(OPCODE_FAIL);
      break;
    case ASMSLOT_FAILTWICEINSTR_FAILTWICE:
      offset += NAIG_INSTR_LENGTH(OPCODE_FAILTWICE);
      break;
    case ASMSLOT_JUMPINSTR_JUMP:
      offset += NAIG_INSTR_LENGTH(OPCODE_JUMP);
      break;
    case ASMSLOT_NOOPINSTR_NOOP:
      offset += NAIG_INSTR_LENGTH(OPCODE_NOOP);
      break;
    case ASMSLOT_OPENCAPTUREINSTR_OPENCAPTURE:
      offset += NAIG_INSTR_LENGTH(OPCODE_OPENCAPTURE);
      break;
    case ASMSLOT_PARTIALCOMMITINSTR_PARTIALCOMMIT:
      offset += NAIG_INSTR_LENGTH(OPCODE_PARTIALCOMMIT);
      break;
    case ASMSLOT_QUADINSTR_QUAD:
      offset += NAIG_INSTR_LENGTH(OPCODE_QUAD);
      break;
    case ASMSLOT_REPLACEINSTR_REPLACE:
      offset += NAIG_INSTR_LENGTH(OPCODE_REPLACE);
      break;
    case ASMSLOT_ENDREPLACEINSTR_ENDREPLACE:
      offset += NAIG_INSTR_LENGTH(OPCODE_ENDREPLACE);
      break;
    case ASMSLOT_RETINSTR_RET:
      offset += NAIG_INSTR_LENGTH(OPCODE_RET);
      break;
    case ASMSLOT_SETINSTR_SET:
      offset += NAIG_INSTR_LENGTH(OPCODE_SET);
      break;
    case ASMSLOT_SKIPINSTR_SKIP:
      offset += NAIG_INSTR_LENGTH(OPCODE_SKIP);
      break;
    case ASMSLOT_SPANINSTR_SPAN:
      offset += NAIG_INSTR_LENGTH(OPCODE_SPAN);
      break;
    case ASMSLOT_TESTANYINSTR_TESTANY:
      offset += NAIG_INSTR_LENGTH(OPCODE_TESTANY);
      break;
    case ASMSLOT_TESTCHARINSTR_TESTCHAR:
      offset += NAIG_INSTR_LENGTH(OPCODE_TESTCHAR);
      break;
    case ASMSLOT_TESTQUADINSTR_TESTQUAD:
      offset += NAIG_INSTR_LENGTH(OPCODE_TESTQUAD);
      break;
    case ASMSLOT_TESTSETINSTR_TESTSET:
      offset += NAIG_INSTR_LENGTH(OPCODE_TESTSET);
      break;
    case ASMSLOT_VARINSTR_VAR:
      offset += NAIG_INSTR_LENGTH(OPCODE_VAR);
      break;
    case ASMSLOT_COUNTERINSTR_COUNTER:
      offset += NAIG_INSTR_LENGTH(OPCODE_COUNTER);
      break;
    case ASMSLOT_CONDJUMPINSTR_CONDJUMP:
      offset += NAIG_INSTR_LENGTH(OPCODE_CONDJUMP);
      break;
    case ASMSLOT_LABELDEF_LABEL:
      CHECK(
        naia_label_put(
          naia,
          naia->assembly + naia->captures->actions[ i ].start,
          naia->captures->actions[ i ].stop
            - naia->captures->actions[ i ].start,
          offset
        )
      );
    }
  }
  return NAIG_OK;
}
