/**
 * This file is part of NAIG.
 * Copyright 2019, KJ Hermans
 * Written by KJ Hermans <kees.jan.hermans@gmail.com>
 *
 * LICENSE:
 * Withheld
 *
 * \file
 * \brief
 */

#include <naigama/engine/naie.h>

/**
 *
 */
char* naie_instr_string
  (uint32_t opcode)
{
  switch (opcode) {
  case OPCODE_ANY:
    return "ANY";
  case OPCODE_CALL:
    return "CALL";
  case OPCODE_CATCH:
    return "CATCH";
  case OPCODE_CHAR:
    return "CHAR";
  case OPCODE_CLOSECAPTURE:
    return "CLOSECAPTURE";
  case OPCODE_COMMIT:
    return "COMMIT";
  case OPCODE_END:
    return "END";
  case OPCODE_FAIL:
    return "FAIL";
  case OPCODE_FAILTWICE:
    return "FAILTWICE";
  case OPCODE_JUMP:
    return "JUMP";
  case OPCODE_NOOP:
    return "NOOP";
  case OPCODE_MASKEDCHAR:
    return "MASKEDCHAR";
  case OPCODE_OPENCAPTURE:
    return "OPENCAPTURE";
  case OPCODE_PARTIALCOMMIT:
    return "PARTIALCOMMIT";
  case OPCODE_QUAD:
    return "QUAD";
  case OPCODE_RET:
    return "RET";
  case OPCODE_SET:
    return "SET";
  case OPCODE_SKIP:
    return "SKIP";
  case OPCODE_SPAN:
    return "SPAN";
  case OPCODE_TESTANY:
    return "TESTANY";
  case OPCODE_TESTCHAR:
    return "TESTCHAR";
  case OPCODE_TESTQUAD:
    return "TESTQUAD";
  case OPCODE_TESTSET:
    return "TESTSET";
  case OPCODE_VAR:
    return "VAR";
  case OPCODE_REPLACE:
    return "REPLACE";
  case OPCODE_ENDREPLACE:
    return "ENDREPLACE";
  }
  return "";
}
