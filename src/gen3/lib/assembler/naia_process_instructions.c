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

#include "naia_private.h"

static
NAIG_ERR_T naia_process_instruction
  (naia_t* naia, naio_resobj_t* object)
{
  switch (object->children[ 0 ]->type) {
  case ASMSLOT_ANYINSTR_ANY:
    CHECK(naia_process_single(naia, OPCODE_ANY)); break;
  case ASMSLOT_BACKCOMMITINSTR_BACKCOMMIT:
    CHECK(naia_process_backcommit(naia, object)); break;
  case ASMSLOT_CALLINSTR_CALL:
    CHECK(naia_process_call(naia, object)); break;
  case ASMSLOT_CATCHINSTR_CATCH:
    CHECK(naia_process_catch(naia, object)); break;
  case ASMSLOT_CHARINSTR_CHAR:
    CHECK(naia_process_char(naia, object)); break;
  case ASMSLOT_MASKEDCHARINSTR_MASKEDCHAR:
    CHECK(naia_process_maskedchar(naia, object)); break;
  case ASMSLOT_CLOSECAPTUREINSTR_CLOSECAPTURE:
    CHECK(naia_process_closecapture(naia, object)); break;
  case ASMSLOT_COMMITINSTR_COMMIT:
    CHECK(naia_process_commit(naia, object)); break;
  case ASMSLOT_ENDINSTR_END:
    CHECK(naia_process_end(naia, object)); break;
  case ASMSLOT_FAILINSTR_FAIL:
    CHECK(naia_process_single(naia, OPCODE_FAIL)); break;
  case ASMSLOT_FAILTWICEINSTR_FAILTWICE:
    CHECK(naia_process_single(naia, OPCODE_FAILTWICE)); break;
  case ASMSLOT_JUMPINSTR_JUMP:
    CHECK(naia_process_jump(naia, object)); break;
  case ASMSLOT_NOOPINSTR_NOOP:
    CHECK(naia_process_single(naia, OPCODE_NOOP)); break;
  case ASMSLOT_TRAPINSTR_TRAP:
    CHECK(naia_process_single(naia, OPCODE_TRAP)); break;
  case ASMSLOT_OPENCAPTUREINSTR_OPENCAPTURE:
    CHECK(naia_process_opencapture(naia, object)); break;
  case ASMSLOT_INTRPCAPTUREINSTR_INTRPCAPTURE:
    CHECK(naia_process_intrpcapture(naia, object)); break;
  case ASMSLOT_PARTIALCOMMITINSTR_PARTIALCOMMIT:
    CHECK(naia_process_partialcommit(naia, object)); break;
  case ASMSLOT_QUADINSTR_QUAD:
    CHECK(naia_process_quad(naia, object)); break;
  case ASMSLOT_RANGEINSTR_RANGE:
    CHECK(naia_process_range(naia, object)); break;
  case ASMSLOT_REPLACEINSTR_REPLACE:
    CHECK(naia_process_replace(naia, object)); break;
  case ASMSLOT_ENDREPLACEINSTR_ENDREPLACE:
    CHECK(naia_process_single(naia, OPCODE_ENDREPLACE)); break;
  case ASMSLOT_RETINSTR_RET:
    CHECK(naia_process_single(naia, OPCODE_RET)); break;
  case ASMSLOT_SETINSTR_SET:
    CHECK(naia_process_set(naia, object)); break;
  case ASMSLOT_SKIPINSTR_SKIP:
    CHECK(naia_process_skip(naia, object)); break;
  case ASMSLOT_SPANINSTR_SPAN:
    CHECK(naia_process_span(naia, object)); break;
  case ASMSLOT_TESTANYINSTR_TESTANY:
    CHECK(naia_process_testany(naia, object)); break;
  case ASMSLOT_TESTCHARINSTR_TESTCHAR:
    CHECK(naia_process_testchar(naia, object)); break;
  case ASMSLOT_TESTQUADINSTR_TESTQUAD:
    CHECK(naia_process_testquad(naia, object)); break;
  case ASMSLOT_TESTSETINSTR_TESTSET:
    CHECK(naia_process_testset(naia, object)); break;
  case ASMSLOT_VARINSTR_VAR:
    CHECK(naia_process_var(naia, object)); break;
  case ASMSLOT_COUNTERINSTR_COUNTER:
    CHECK(naia_process_counter(naia, object)); break;
  case ASMSLOT_CONDJUMPINSTR_CONDJUMP:
    CHECK(naia_process_condjump(naia, object)); break;
  case ASMSLOT_ISOLATEINSTR_ISOLATE:
    CHECK(naia_process_isolate(naia, object)); break;
  case ASMSLOT_ENDISOLATEINSTR_ENDISOLATE:
    CHECK(naia_process_single(naia, OPCODE_ENDISOLATE)); break;

  case ASMSLOT_LABEL_AZAZ:
    /* ignore */
    break;
  default:
    fprintf(stderr, "Unknown slot %u\n", object->children[0]->type);
    naio_resobj_debug(object, 0);
  }
  return NAIG_OK;
}

/**
 * Second pass; translate instructions to bytecode.
 */
NAIG_ERR_T naia_process_instructions
  (naia_t* naia, naio_resobj_t* object)
{
  unsigned i;

  for (i=0; i < object->nchildren; i++) {
    switch (object->children[ i ]->type) {
    case ASMSLOT_INSTRUCTION_RULEINSTR:
      CHECK(naia_process_instruction(naia, object->children[ i ]));
      break;
    case ASMSLOT_INSTRUCTION_LABELDEF:
      break; // ignore
    }
  }
#ifdef _DEBUG
  fprintf(stderr, "Assembler: %u instructions (incl labels)\n"
    , object->nchildren);
#endif
  return NAIG_OK;
}
