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

#include "naid_private.h"
#include "bytecode_slotmap.h"

#include <naigama/util/bin.h>

static
void naid_disassemble_instr_bin
  (naid_t* naid, unsigned* offset, char* mnem, char* bin)
{
  uint32_t param = GET_32BIT_VALUE((unsigned char*)bin, 4);
  td_printf(&(naid->output.string), "%u: %s %u\n", *offset, mnem, param);
  (*offset) += 8;
}

static
void naid_disassemble_instr_trip
  (naid_t* naid, unsigned* offset, char* mnem, char* bin)
{
  uint32_t param1 = GET_32BIT_VALUE((unsigned char*)bin, 4);
  uint32_t param2 = GET_32BIT_VALUE((unsigned char*)bin, 8);
  td_printf(&(naid->output.string), "%u: %s %u %u\n", *offset, mnem, param1, param2);
  (*offset) += 12;
}

static
void naid_disassemble_instr_hex
  (naid_t* naid, unsigned offset, char* mnem, char* bin, unsigned size)
{
  td_printf(&(naid->output.string), "%u: %s ", offset, mnem);
  for (unsigned i=0; i < size; i++) {
    td_printf(&(naid->output.string), "%.2x", (unsigned char)(bin[ i ]));
  }
  td_printf(&(naid->output.string), "\n");
}

static
void naid_disassemble_instr_bin_hex
  (naid_t* naid, unsigned offset, char* mnem, char* bin, unsigned start, unsigned size)
{
  uint32_t param = GET_32BIT_VALUE((unsigned char*)bin, 4);
  td_printf(&(naid->output.string), "%u: %s ", offset, mnem);
  for (unsigned i=0; i < size; i++) {
    td_printf(&(naid->output.string), "%.2x", (unsigned char)(bin[ i+start ]));
  }
  td_printf(&(naid->output.string), "%u\n", param);
}

/**
 *
 */
NAIG_ERR_T naid_disassemble
  (naid_t* naid, char* inputfile)
{
  unsigned offset = 0;
  naig_resobj_t* instr;

  NAIG_CHECK(naid_parse(naid, inputfile), PROPAGATE);
  for (unsigned i=0; i < naid->parsetree->nchildren; i++) {
    instr = naid->parsetree->children[ i ];
    switch (instr->type) {
    case SLOTMAP_INSTR_ANY:
      td_printf(&(naid->output.string), "%u: any\n", offset);
      offset += 4;
      break;
    case SLOTMAP_INSTR_BACKCOMMIT:
      naid_disassemble_instr_bin(naid, &offset, "backcommit", instr->string);
      break;
    case SLOTMAP_INSTR_CALL:
      naid_disassemble_instr_bin(naid, &offset, "call", instr->string);
      break;
    case SLOTMAP_INSTR_CATCH:
      naid_disassemble_instr_bin(naid, &offset, "catch", instr->string);
      break;
    case SLOTMAP_INSTR_CHAR:
      naid_disassemble_instr_hex(naid, offset, "char", instr->string + 7, 1);
      offset += 8;
      break;
    case SLOTMAP_INSTR_CLOSECAPTURE:
      naid_disassemble_instr_bin(naid, &offset, "closecapture", instr->string);
      break;
    case SLOTMAP_INSTR_COMMIT:
      naid_disassemble_instr_bin(naid, &offset, "commit", instr->string);
      break;
    case SLOTMAP_INSTR_CONDJUMP:
      naid_disassemble_instr_trip(naid, &offset, "condjump", instr->string);
      break;
    case SLOTMAP_INSTR_COUNTER:
      naid_disassemble_instr_trip(naid, &offset, "counter", instr->string);
      break;
    case SLOTMAP_INSTR_END:
      naid_disassemble_instr_bin(naid, &offset, "end", instr->string);
      break;
    case SLOTMAP_INSTR_ENDISOLATE:
      td_printf(&(naid->output.string), "%u: endisolate\n", offset);
      offset += 4;
      break;
    case SLOTMAP_INSTR_ENDREPLACE:
      td_printf(&(naid->output.string), "%u: endreplace\n", offset);
      offset += 4;
      break;
    case SLOTMAP_INSTR_FAIL:
      td_printf(&(naid->output.string), "%u: fail\n", offset);
      offset += 4;
      break;
    case SLOTMAP_INSTR_FAILTWICE:
      td_printf(&(naid->output.string), "%u: failtwice\n", offset);
      offset += 4;
      break;
    case SLOTMAP_INSTR_INTRPCAPTURE:
      naid_disassemble_instr_trip(naid, &offset, "intrpcapture", instr->string);
      break;
    case SLOTMAP_INSTR_ISOLATE:
      naid_disassemble_instr_bin(naid, &offset, "isolate", instr->string);
      break;
    case SLOTMAP_INSTR_JUMP:
      naid_disassemble_instr_bin(naid, &offset, "jump", instr->string);
      break;
    case SLOTMAP_INSTR_MASKEDCHAR:
      td_printf(&(naid->output.string),
        "%u: maskedchar %.2x %.2x\n"
        , offset
        , (unsigned char)(instr->string[ 7 ])
        , (unsigned char)(instr->string[ 11 ])
      );
      offset += 12;
      break;
    case SLOTMAP_INSTR_NOOP:
      td_printf(&(naid->output.string), "%u: noop\n", offset);
      offset += 4;
      break;
    case SLOTMAP_INSTR_OPENCAPTURE:
      naid_disassemble_instr_bin(naid, &offset, "opencapture", instr->string);
      break;
    case SLOTMAP_INSTR_PARTIALCOMMIT:
      naid_disassemble_instr_bin(naid, &offset, "partialcommit", instr->string);
      break;
    case SLOTMAP_INSTR_QUAD:
      naid_disassemble_instr_hex(naid, offset, "quad", instr->string + 4, 4);
      offset += 8;
      break;
    case SLOTMAP_INSTR_RANGE:
      naid_disassemble_instr_trip(naid, &offset, "range", instr->string);
      break;
    case SLOTMAP_INSTR_REPLACE:
      naid_disassemble_instr_trip(naid, &offset, "replace", instr->string);
      break;
    case SLOTMAP_INSTR_RET:
      td_printf(&(naid->output.string), "%u: ret\n", offset);
      offset += 4;
      break;
    case SLOTMAP_INSTR_SET:
      naid_disassemble_instr_hex(naid, offset, "set", instr->string + 4, 32);
      offset += 36;
      break;
    case SLOTMAP_INSTR_SKIP:
      naid_disassemble_instr_bin(naid, &offset, "skip", instr->string);
      break;
    case SLOTMAP_INSTR_SPAN:
      naid_disassemble_instr_hex(naid, offset, "span", instr->string + 4, 32);
      offset += 36;
      break;
    case SLOTMAP_INSTR_TESTANY:
      naid_disassemble_instr_bin(naid, &offset, "testany", instr->string);
      offset += 8;
      break;
    case SLOTMAP_INSTR_TESTCHAR:
      naid_disassemble_instr_bin_hex(naid, offset, "testchar", instr->string, 11, 1);
      offset += 12;
      break;
    case SLOTMAP_INSTR_TESTQUAD:
      naid_disassemble_instr_bin_hex(naid, offset, "testquad", instr->string, 8, 4);
      offset += 12;
      break;
    case SLOTMAP_INSTR_TESTSET:
      naid_disassemble_instr_bin_hex(naid, offset, "testset", instr->string, 8, 32);
      offset += 40;
      break;
    case SLOTMAP_INSTR_TRAP:
      td_printf(&(naid->output.string), "%u: trap\n", offset);
      offset += 4;
      break;
    case SLOTMAP_INSTR_VAR:
      naid_disassemble_instr_bin(naid, &offset, "var", instr->string);
      break;
    }
  }
  return NAIG_OK;
}
