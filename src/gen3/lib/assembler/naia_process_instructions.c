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

/**
 * Topmost function
 */
NAIG_ERR_T naia_process_instructions
  (naia_t* naia)
{
  unsigned i;

  for (i=0; i < naia->captures->count; i++) {
    switch (naia->captures->actions[ i ].slot) {
    case ASMSLOT_ANYINSTR_ANY:
      CHECK(naia_process_any(naia, i)); break;
    case ASMSLOT_BACKCOMMITINSTR_BACKCOMMIT:
      CHECK(naia_process_backcommit(naia, i)); break;
    case ASMSLOT_CALLINSTR_CALL:
      CHECK(naia_process_call(naia, i)); break;
    case ASMSLOT_CATCHINSTR_CATCH:
      CHECK(naia_process_catch(naia, i)); break;
    case ASMSLOT_CHARINSTR_CHAR:
      CHECK(naia_process_char(naia, i)); break;
    case ASMSLOT_MASKEDCHARINSTR_MASKEDCHAR:
      CHECK(naia_process_maskedchar(naia, i)); break;
    case ASMSLOT_CLOSECAPTUREINSTR_CLOSECAPTURE:
      CHECK(naia_process_closecapture(naia, i)); break;
    case ASMSLOT_COMMITINSTR_COMMIT:
      CHECK(naia_process_commit(naia, i)); break;
    case ASMSLOT_ENDINSTR_END:
      CHECK(naia_process_end(naia, i)); break;
    case ASMSLOT_FAILINSTR_FAIL:
      CHECK(naia_process_fail(naia, i)); break;
    case ASMSLOT_FAILTWICEINSTR_FAILTWICE:
      CHECK(naia_process_failtwice(naia, i)); break;
    case ASMSLOT_JUMPINSTR_JUMP:
      CHECK(naia_process_jump(naia, i)); break;
    case ASMSLOT_NOOPINSTR_NOOP:
      CHECK(naia_process_noop(naia, i)); break;
    case ASMSLOT_TRAPINSTR_TRAP:
      CHECK(naia_process_trap(naia, i)); break;
    case ASMSLOT_OPENCAPTUREINSTR_OPENCAPTURE:
      CHECK(naia_process_opencapture(naia, i)); break;
    case ASMSLOT_PARTIALCOMMITINSTR_PARTIALCOMMIT:
      CHECK(naia_process_partialcommit(naia, i)); break;
    case ASMSLOT_QUADINSTR_QUAD:
      CHECK(naia_process_quad(naia, i)); break;
    case ASMSLOT_REPLACEINSTR_REPLACE:
      CHECK(naia_process_replace(naia, i)); break;
    case ASMSLOT_ENDREPLACEINSTR_ENDREPLACE:
      CHECK(naia_process_endreplace(naia, i)); break;
    case ASMSLOT_RETINSTR_RET:
      CHECK(naia_process_ret(naia, i)); break;
    case ASMSLOT_SETINSTR_SET:
      CHECK(naia_process_set(naia, i)); break;
    case ASMSLOT_SKIPINSTR_SKIP:
      CHECK(naia_process_skip(naia, i)); break;
    case ASMSLOT_SPANINSTR_SPAN:
      CHECK(naia_process_span(naia, i)); break;
    case ASMSLOT_TESTANYINSTR_TESTANY:
      CHECK(naia_process_testany(naia, i)); break;
    case ASMSLOT_TESTCHARINSTR_TESTCHAR:
      CHECK(naia_process_testchar(naia, i)); break;
    case ASMSLOT_TESTQUADINSTR_TESTQUAD:
      CHECK(naia_process_testquad(naia, i)); break;
    case ASMSLOT_TESTSETINSTR_TESTSET:
      CHECK(naia_process_testset(naia, i)); break;
    case ASMSLOT_VARINSTR_VAR:
      CHECK(naia_process_var(naia, i)); break;
    case ASMSLOT_COUNTERINSTR_COUNTER:
      CHECK(naia_process_counter(naia, i)); break;
    case ASMSLOT_CONDJUMPINSTR_CONDJUMP:
      CHECK(naia_process_condjump(naia, i)); break;
    case ASMSLOT_ISOLATEINSTR_ISOLATE:
      CHECK(naia_process_isolate(naia, i)); break;
    case ASMSLOT_ENDISOLATEINSTR_ENDISOLATE:
      CHECK(naia_process_endisolate(naia, i)); break;

    case ASMSLOT_SCR_ADD_SADD:
      CHECK(naia_process_scr_add(naia, i)); break;
    case ASMSLOT_SCR_CALL_SCALL:
      CHECK(naia_process_scr_call(naia, i)); break;
    case ASMSLOT_SCR_PUSH_SPUSH:
      CHECK(naia_process_scr_push(naia, i)); break;
    case ASMSLOT_SCR_RET_SRET:
      CHECK(naia_process_scr_ret(naia, i)); break;
    case ASMSLOT_SCR_BUILTIN_SBUILTIN:
      CHECK(naia_process_scr_builtin(naia, i)); break;
    case ASMSLOT_SCR_STRING_SSTRING:
      CHECK(naia_process_scr_string(naia, i)); break;
      break;

    }
  }
  return NAIG_OK;
}
