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
    CHECK(naid->write(naid->write_arg, "%*u: ", 4, bytecode_offset));
    opcode = GET_32BIT_VALUE(naid->bytecode, bytecode_offset);
    instrlength = naid->bytecode[ bytecode_offset + 1 ] + 4;
    if (bytecode_offset + instrlength > naid->bytecode_length) {
      RETURNERR(NAID_ERR_OVERFLOW);
    }
    switch (opcode) {
    case OPCODE_ANY:
      CHECK(naid->write(naid->write_arg, "any\n"));
      break;
    case OPCODE_BACKCOMMIT:
      param1 = GET_32BIT_VALUE(naid->bytecode, bytecode_offset + 4);
      CHECK(naid->write(naid->write_arg, "backcommit %u\n", param1));
      if (param1 > naid->bytecode_length) {
        CHECK(naid->write(naid->write_arg, "-- ERROR: Jump out of bounds.\n"));
      }
      break;
    case OPCODE_CALL:
      param1 = GET_32BIT_VALUE(naid->bytecode, bytecode_offset + 4);
      CHECK(naid->write(naid->write_arg, "call %u\n", param1));
      if (param1 > naid->bytecode_length) {
        CHECK(naid->write(naid->write_arg, "-- ERROR: Jump out of bounds.\n"));
      }
      break;
    case OPCODE_CATCH:
      param1 = GET_32BIT_VALUE(naid->bytecode, bytecode_offset + 4);
      CHECK(naid->write(naid->write_arg, "catch %u\n", param1));
      if (param1 > naid->bytecode_length) {
        CHECK(naid->write(naid->write_arg, "-- ERROR: Jump out of bounds.\n"));
      }
      break;
    case OPCODE_CHAR:
      param1 = GET_32BIT_VALUE(naid->bytecode, bytecode_offset + 4);
      CHECK(naid->write(naid->write_arg, "char %.2x\n", param1));
      break;
    case OPCODE_CLOSECAPTURE:
      param1 = GET_32BIT_VALUE(naid->bytecode, bytecode_offset + 4);
      CHECK(naid->write(naid->write_arg, "closecapture %u\n", param1));
      break;
    case OPCODE_COMMIT:
      param1 = GET_32BIT_VALUE(naid->bytecode, bytecode_offset + 4);
      CHECK(naid->write(naid->write_arg, "commit %u\n", param1));
      if (param1 > naid->bytecode_length) {
        CHECK(naid->write(naid->write_arg, "-- ERROR: Jump out of bounds.\n"));
      }
      break;
    case OPCODE_CONDJUMP:
      param1 = GET_32BIT_VALUE(naid->bytecode, bytecode_offset + 4);
      param2 = GET_32BIT_VALUE(naid->bytecode, bytecode_offset + 8);
      CHECK(naid->write(naid->write_arg, "condjump %u %u\n", param1, param2));
      if (param2 > naid->bytecode_length) {
        CHECK(naid->write(naid->write_arg, "-- ERROR: Jump out of bounds.\n"));
      }
      break;
    case OPCODE_COUNTER:
      param1 = GET_32BIT_VALUE(naid->bytecode, bytecode_offset + 4);
      param2 = GET_32BIT_VALUE(naid->bytecode, bytecode_offset + 8);
      CHECK(naid->write(naid->write_arg, "counter %u %u\n", param1, param2));
      break;
    case OPCODE_END:
      param1 = GET_32BIT_VALUE(naid->bytecode, bytecode_offset + 4);
      CHECK(naid->write(naid->write_arg, "end %u\n", param1));
      break;
    case OPCODE_ENDREPLACE:
      CHECK(naid->write(naid->write_arg, "endreplace\n", param1));
      break;
    case OPCODE_FAIL:
      CHECK(naid->write(naid->write_arg, "fail\n", param1));
      break;
    case OPCODE_FAILTWICE:
      CHECK(naid->write(naid->write_arg, "failtwice\n", param1));
      break;
    case OPCODE_JUMP:
      param1 = GET_32BIT_VALUE(naid->bytecode, bytecode_offset + 4);
      CHECK(naid->write(naid->write_arg, "jump %u\n", param1));
      if (param1 > naid->bytecode_length) {
        CHECK(naid->write(naid->write_arg, "-- ERROR: Jump out of bounds.\n"));
      }
      break;
    case OPCODE_MASKEDCHAR:
      param1 = GET_32BIT_VALUE(naid->bytecode, bytecode_offset + 4);
      param2 = GET_32BIT_VALUE(naid->bytecode, bytecode_offset + 8);
      CHECK(naid->write(naid->write_arg, "maskedchar %.2x %.2x\n", param1, param2));
      break;
    case OPCODE_NOOP:
      CHECK(naid->write(naid->write_arg, "noop\n", param1));
      break;
    case OPCODE_OPENCAPTURE:
      param1 = GET_32BIT_VALUE(naid->bytecode, bytecode_offset + 4);
      CHECK(naid->write(naid->write_arg, "opencapture %u\n", param1));
      break;
    case OPCODE_PARTIALCOMMIT:
      param1 = GET_32BIT_VALUE(naid->bytecode, bytecode_offset + 4);
      CHECK(naid->write(naid->write_arg, "partialcommit %u\n", param1));
      if (param1 > naid->bytecode_length) {
        CHECK(naid->write(naid->write_arg, "-- ERROR: Jump out of bounds.\n"));
      }
      break;
    case OPCODE_QUAD:
      param1 = GET_32BIT_VALUE(naid->bytecode, bytecode_offset + 4);
      CHECK(naid->write(naid->write_arg, "char %.8x\n", param1));
      break;
    case OPCODE_RANGE:
      param1 = GET_32BIT_VALUE(naid->bytecode, bytecode_offset + 4);
      param2 = GET_32BIT_VALUE(naid->bytecode, bytecode_offset + 8);
      CHECK(naid->write(naid->write_arg, "range %u %u\n", param1, param2));
      break;
    case OPCODE_REPLACE:
      param1 = GET_32BIT_VALUE(naid->bytecode, bytecode_offset + 4);
      param2 = GET_32BIT_VALUE(naid->bytecode, bytecode_offset + 8);
      CHECK(naid->write(naid->write_arg, "replace %u %u\n", param1, param2));
      if (param2 > naid->bytecode_length) {
        CHECK(naid->write(naid->write_arg, "-- ERROR: Jump out of bounds.\n"));
      }
      break;
    case OPCODE_RET:
      CHECK(naid->write(naid->write_arg, "ret\n", param1));
      break;
    case OPCODE_SET:
      CHECK(naid->write(naid->write_arg, "set ", param1));
      for (i=0; i < 32; i++) {
        CHECK(naid->write(naid->write_arg, "%.2x", naid->bytecode[ bytecode_offset + 4 + i ]));
      }
      CHECK(naid->write(naid->write_arg, "\n"));
      break;
    case OPCODE_SKIP:
      param1 = GET_32BIT_VALUE(naid->bytecode, bytecode_offset + 4);
      CHECK(naid->write(naid->write_arg, "skip %u\n", param1));
      break;
    case OPCODE_SPAN:
      CHECK(naid->write(naid->write_arg, "span ", param1));
      for (i=0; i < 32; i++) {
        CHECK(naid->write(naid->write_arg, "%.2x", naid->bytecode[ bytecode_offset + 4 + i ]));
      }
      CHECK(naid->write(naid->write_arg, "\n"));
      break;
    case OPCODE_TESTANY:
      param1 = GET_32BIT_VALUE(naid->bytecode, bytecode_offset + 4);
      CHECK(naid->write(naid->write_arg, "testany %u\n", param1));
      if (param1 > naid->bytecode_length) {
        CHECK(naid->write(naid->write_arg, "-- ERROR: Jump out of bounds.\n"));
      }
      break;
    case OPCODE_TESTCHAR:
      param1 = GET_32BIT_VALUE(naid->bytecode, bytecode_offset + 4);
      param2 = GET_32BIT_VALUE(naid->bytecode, bytecode_offset + 8);
      CHECK(naid->write(naid->write_arg, "testchar %.2x %u\n", param2, param1));
      if (param1 > naid->bytecode_length) {
        CHECK(naid->write(naid->write_arg, "-- ERROR: Jump out of bounds.\n"));
      }
      break;
    case OPCODE_TESTQUAD:
      param1 = GET_32BIT_VALUE(naid->bytecode, bytecode_offset + 4);
      param2 = GET_32BIT_VALUE(naid->bytecode, bytecode_offset + 8);
      CHECK(naid->write(naid->write_arg, "testquad %.8x %u\n", param2, param1));
      if (param1 > naid->bytecode_length) {
        CHECK(naid->write(naid->write_arg, "-- ERROR: Jump out of bounds.\n"));
      }
      break;
    case OPCODE_TESTSET:
      param1 = GET_32BIT_VALUE(naid->bytecode, bytecode_offset + 4);
      CHECK(naid->write(naid->write_arg, "testset "));
      for (i=0; i < 32; i++) {
        CHECK(naid->write(naid->write_arg, "%.2x", naid->bytecode[ bytecode_offset + 8 + i ]));
      }
      CHECK(naid->write(naid->write_arg, " %u\n", param1));
      if (param1 > naid->bytecode_length) {
        CHECK(naid->write(naid->write_arg, "-- ERROR: Jump out of bounds.\n"));
      }
      break;
    case OPCODE_TRAP:
      CHECK(naid->write(naid->write_arg, "trap\n", param1));
      break;
    case OPCODE_VAR:
      param1 = GET_32BIT_VALUE(naid->bytecode, bytecode_offset + 4);
      CHECK(naid->write(naid->write_arg, "var %u\n", param1));
      break;
    case OPCODE_ISOLATE:
      param1 = GET_32BIT_VALUE(naid->bytecode, bytecode_offset + 4);
      CHECK(naid->write(naid->write_arg, "isolate %u\n", param1));
      break;
    case OPCODE_ENDISOLATE:
      CHECK(naid->write(naid->write_arg, "endisolate\n"));
      break;
    case OPCODE_SCR_CALL:
      param1 = GET_32BIT_VALUE(naid->bytecode, bytecode_offset + 4);
      CHECK(naid->write(naid->write_arg, "__s:call %u\n", param1));
      if (param1 > naid->bytecode_length) {
        CHECK(naid->write(naid->write_arg, "-- ERROR: Jump out of bounds.\n"));
      }
      break;
    case OPCODE_SCR_PUSH:
      param1 = GET_32BIT_VALUE(naid->bytecode, bytecode_offset + 4);
      switch (param1) {
      case NAIE_SCALAR_TYPE_VOID:
        CHECK(naid->write(naid->write_arg, "__s:push __void\n"));
        break;
      case NAIE_SCALAR_TYPE_BOOLEAN:
        param2 = GET_32BIT_VALUE(naid->bytecode, bytecode_offset + 8);
        CHECK(naid->write(naid->write_arg, "__s:push %u\n", param2));
        break;
      case NAIE_SCALAR_TYPE_UNSIGNED:
        param2 = GET_32BIT_VALUE(naid->bytecode, bytecode_offset + 8);
        CHECK(naid->write(naid->write_arg, "__s:push %u\n", param2));
        break;
      case NAIE_SCALAR_TYPE_INT:
        param2 = GET_32BIT_VALUE(naid->bytecode, bytecode_offset + 8);
        CHECK(naid->write(naid->write_arg, "__s:push %u\n", param2));
        break;
      case NAIE_SCALAR_TYPE_FLOAT:
        break;
      case NAIE_SCALAR_TYPE_STRING:
        param2 = GET_32BIT_VALUE(naid->bytecode, bytecode_offset + 8);
        CHECK(naid->write(naid->write_arg, "__s:push __string %u\n", param2));
        break;
      case NAIE_SCALAR_TYPE_REGISTER:
        param2 = GET_32BIT_VALUE(naid->bytecode, bytecode_offset + 8);
        CHECK(naid->write(naid->write_arg, "__s:push { %u }\n", param2));
        break;
      case NAIE_SCALAR_TYPE_STACKRETURN:
        CHECK(naid->write(naid->write_arg, "__s:push __function\n", param2));
        break;
      }
      break;
    case OPCODE_SCR_ADD:
      CHECK(naid->write(naid->write_arg, "__s:add\n"));
      break;
    case OPCODE_SCR_BUILTIN:
      param1 = GET_32BIT_VALUE(naid->bytecode, bytecode_offset + 4);
      CHECK(naid->write(naid->write_arg, "__s:builtin %u\n", param1));
      break;
    case OPCODE_SCR_RET:
      CHECK(naid->write(naid->write_arg, "__s:ret\n"));
      break;
    case OPCODE_SCR_STRING:
      param1 = GET_32BIT_VALUE(naid->bytecode, bytecode_offset + 4);
      CHECK(naid->write(naid->write_arg, "__s:string '%-.*s'\n"
        , param1, naid->bytecode + bytecode_offset + 8
      ));
      bytecode_offset += ((2 * sizeof(uint32_t)) + ROUNDUP(sizeof(uint32_t), param1));
      break;
    default:
      naid->write(naid->write_arg, "-- Unknown opcode %.8x\n", opcode);
      RETURNERR(NAID_ERR_OPCODE);
    }
    bytecode_offset += instrlength;
  }
  return NAIG_OK;
}
