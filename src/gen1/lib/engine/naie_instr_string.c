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

#include "naie_private.h"

/**
 * Returns a string value for each opcode.
 * This C file should be automatically generated.
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
  case OPCODE_COUNTER:
    return "COUNTER";
  case OPCODE_CONDJUMP:
    return "CONDJUMP";
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
  case OPCODE_BACKCOMMIT:
    return "BACKCOMMIT";
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
