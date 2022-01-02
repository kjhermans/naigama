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

#include "naid_private.h"

/**
 *
 */
NAIG_ERR_T naid_do_disassemble
  (naid_t* naid)
{
  unsigned bytecode_offset = 0;
  uint32_t opcode, param1, param2;
  unsigned instrlength, i;

  while (bytecode_offset < naid->bytecode_length) {
    NAID_WRITE("%*u: ", 4, bytecode_offset);
    opcode = GET_32BIT_VALUE(naid->bytecode, bytecode_offset);
    instrlength = naid->bytecode[ bytecode_offset + 1 ] + 4;
    if (bytecode_offset + instrlength > naid->bytecode_length) {
      RETURNERR(NAIG_ERR_OVERFLOW);
    }
//fprintf(stdout, "OPCODE %u\n", opcode);
    switch (opcode) {
    case OPCODE_ANY:
      NAID_WRITE("any\n");
      break;
    case OPCODE_BACKCOMMIT:
      param1 = GET_32BIT_VALUE(naid->bytecode, bytecode_offset + 4);
      NAID_WRITE("backcommit %u\n", param1);
      if (param1 > naid->bytecode_length) {
        NAID_WRITE("-- ERROR: Jump out of bounds.\n");
      }
      break;
    case OPCODE_CALL:
      param1 = GET_32BIT_VALUE(naid->bytecode, bytecode_offset + 4);
      NAID_WRITE("call %u\n", param1);
      if (param1 > naid->bytecode_length) {
        NAID_WRITE("-- ERROR: Jump out of bounds.\n");
      }
      break;
    case OPCODE_CATCH:
      param1 = GET_32BIT_VALUE(naid->bytecode, bytecode_offset + 4);
      NAID_WRITE("catch %u\n", param1);
      if (param1 > naid->bytecode_length) {
        NAID_WRITE("-- ERROR: Jump out of bounds.\n");
      }
      break;
    case OPCODE_CHAR:
      param1 = GET_32BIT_VALUE(naid->bytecode, bytecode_offset + 4);
      NAID_WRITE("char %.2x\n", param1);
      break;
    case OPCODE_CLOSECAPTURE:
      param1 = GET_32BIT_VALUE(naid->bytecode, bytecode_offset + 4);
      NAID_WRITE("closecapture %u\n", param1);
      break;
    case OPCODE_COMMIT:
      param1 = GET_32BIT_VALUE(naid->bytecode, bytecode_offset + 4);
      NAID_WRITE("commit %u\n", param1);
      if (param1 > naid->bytecode_length) {
        NAID_WRITE("-- ERROR: Jump out of bounds.\n");
      }
      break;
    case OPCODE_CONDJUMP:
      param1 = GET_32BIT_VALUE(naid->bytecode, bytecode_offset + 4);
      param2 = GET_32BIT_VALUE(naid->bytecode, bytecode_offset + 8);
      NAID_WRITE("condjump %u %u\n", param1, param2);
      if (param2 > naid->bytecode_length) {
        NAID_WRITE("-- ERROR: Jump out of bounds.\n");
      }
      break;
    case OPCODE_COUNTER:
      param1 = GET_32BIT_VALUE(naid->bytecode, bytecode_offset + 4);
      param2 = GET_32BIT_VALUE(naid->bytecode, bytecode_offset + 8);
      NAID_WRITE("counter %u %u\n", param1, param2);
      break;
    case OPCODE_END:
      param1 = GET_32BIT_VALUE(naid->bytecode, bytecode_offset + 4);
      NAID_WRITE("end %u\n", param1);
      break;
    case OPCODE_ENDREPLACE:
      NAID_WRITE("endreplace\n", param1);
      break;
    case OPCODE_FAIL:
      NAID_WRITE("fail\n", param1);
      break;
    case OPCODE_FAILTWICE:
      NAID_WRITE("failtwice\n", param1);
      break;
    case OPCODE_INTRPCAPTURE:
      param1 = GET_32BIT_VALUE(naid->bytecode, bytecode_offset + 4);
      param2 = GET_32BIT_VALUE(naid->bytecode, bytecode_offset + 8);
      NAID_WRITE("intrpcapture %u %u\n", param1, param2);
      break;
    case OPCODE_JUMP:
      param1 = GET_32BIT_VALUE(naid->bytecode, bytecode_offset + 4);
      NAID_WRITE("jump %u\n", param1);
      if (param1 > naid->bytecode_length) {
        NAID_WRITE("-- ERROR: Jump out of bounds.\n");
      }
      break;
    case OPCODE_MASKEDCHAR:
      param1 = GET_32BIT_VALUE(naid->bytecode, bytecode_offset + 4);
      param2 = GET_32BIT_VALUE(naid->bytecode, bytecode_offset + 8);
      NAID_WRITE("maskedchar %.2x %.2x\n", param1, param2);
      break;
    case OPCODE_NOOP:
      NAID_WRITE("noop\n", param1);
      break;
    case OPCODE_OPENCAPTURE:
      param1 = GET_32BIT_VALUE(naid->bytecode, bytecode_offset + 4);
      NAID_WRITE("opencapture %u\n", param1);
      break;
    case OPCODE_PARTIALCOMMIT:
      param1 = GET_32BIT_VALUE(naid->bytecode, bytecode_offset + 4);
      NAID_WRITE("partialcommit %u\n", param1);
      if (param1 > naid->bytecode_length) {
        NAID_WRITE("-- ERROR: Jump out of bounds.\n");
      }
      break;
    case OPCODE_QUAD:
      param1 = GET_32BIT_VALUE(naid->bytecode, bytecode_offset + 4);
      NAID_WRITE("char %.8x\n", param1);
      break;
    case OPCODE_RANGE:
      param1 = GET_32BIT_VALUE(naid->bytecode, bytecode_offset + 4);
      param2 = GET_32BIT_VALUE(naid->bytecode, bytecode_offset + 8);
      NAID_WRITE("range %u %u\n", param1, param2);
      break;
    case OPCODE_REPLACE:
      param1 = GET_32BIT_VALUE(naid->bytecode, bytecode_offset + 4);
      param2 = GET_32BIT_VALUE(naid->bytecode, bytecode_offset + 8);
      NAID_WRITE("replace %u %u\n", param1, param2);
      if (param2 > naid->bytecode_length) {
        NAID_WRITE("-- ERROR: Jump out of bounds.\n");
      }
      break;
    case OPCODE_RET:
      NAID_WRITE("ret\n", param1);
      break;
    case OPCODE_SET:
      NAID_WRITE("set ", param1);
      for (i=0; i < 32; i++) {
        NAID_WRITE("%.2x", naid->bytecode[ bytecode_offset + 4 + i ]);
      }
      NAID_WRITE("\n");
      break;
    case OPCODE_SKIP:
      param1 = GET_32BIT_VALUE(naid->bytecode, bytecode_offset + 4);
      NAID_WRITE("skip %u\n", param1);
      break;
    case OPCODE_SPAN:
      NAID_WRITE("span ", param1);
      for (i=0; i < 32; i++) {
        NAID_WRITE("%.2x", naid->bytecode[ bytecode_offset + 4 + i ]);
      }
      NAID_WRITE("\n");
      break;
    case OPCODE_TESTANY:
      param1 = GET_32BIT_VALUE(naid->bytecode, bytecode_offset + 4);
      NAID_WRITE("testany %u\n", param1);
      if (param1 > naid->bytecode_length) {
        NAID_WRITE("-- ERROR: Jump out of bounds.\n");
      }
      break;
    case OPCODE_TESTCHAR:
      param1 = GET_32BIT_VALUE(naid->bytecode, bytecode_offset + 4);
      param2 = GET_32BIT_VALUE(naid->bytecode, bytecode_offset + 8);
      NAID_WRITE("testchar %.2x %u\n", param2, param1);
      if (param1 > naid->bytecode_length) {
        NAID_WRITE("-- ERROR: Jump out of bounds.\n");
      }
      break;
    case OPCODE_TESTQUAD:
      param1 = GET_32BIT_VALUE(naid->bytecode, bytecode_offset + 4);
      param2 = GET_32BIT_VALUE(naid->bytecode, bytecode_offset + 8);
      NAID_WRITE("testquad %.8x %u\n", param2, param1);
      if (param1 > naid->bytecode_length) {
        NAID_WRITE("-- ERROR: Jump out of bounds.\n");
      }
      break;
    case OPCODE_TESTSET:
      param1 = GET_32BIT_VALUE(naid->bytecode, bytecode_offset + 4);
      NAID_WRITE("testset ");
      for (i=0; i < 32; i++) {
        NAID_WRITE("%.2x", naid->bytecode[ bytecode_offset + 8 + i ]);
      }
      NAID_WRITE(" %u\n", param1);
      if (param1 > naid->bytecode_length) {
        NAID_WRITE("-- ERROR: Jump out of bounds.\n");
      }
      break;
    case OPCODE_TRAP:
      NAID_WRITE("trap\n", param1);
      break;
    case OPCODE_VAR:
      param1 = GET_32BIT_VALUE(naid->bytecode, bytecode_offset + 4);
      NAID_WRITE("var %u\n", param1);
      break;
    case OPCODE_ISOLATE:
      param1 = GET_32BIT_VALUE(naid->bytecode, bytecode_offset + 4);
      NAID_WRITE("isolate %u\n", param1);
      break;
    case OPCODE_ENDISOLATE:
      NAID_WRITE("endisolate\n");
      break;
    default:
      naid->write(naid->write_arg, "-- Unknown opcode %.8x\n", opcode);
      RETURNERR(NAIG_ERR_OPCODE);
    }
    bytecode_offset += instrlength;
  }
  return NAIG_OK;
}
