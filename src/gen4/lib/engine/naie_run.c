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

#include <naigama/util/bin.h>

#include "naie_private.h"

#define HANDLE_NOOP { \
  ec->bytecode_offset += instruction_size; \
}

#define HANDLE_END { \
  uint32_t param = GET_32BIT_VALUE( \
    naie->bytecode.data, \
    ec->bytecode_offset + 8 \
  ); \
  ec->endcode = param; \
  return NAIG_OK; \
}

#define HANDLE_ANY { \
  if (ec->input_offset < ec->input.size) { \
    ++(ec->input_offset); \
    ec->bytecode_offset += instruction_size; \
  } else { \
    ec->failed = 1; \
  } \
}

#define HANDLE_SKIP { \
  uint32_t param = GET_32BIT_VALUE( \
    naie->bytecode.data, \
    ec->bytecode_offset + 4 \
  ); \
  if (ec->input_offset <= ec->input.size - param) { \
    ec->input_offset += param; \
    ec->bytecode_offset += instruction_size; \
  } else { \
    ec->failed = 1; \
  } \
}

#define HANDLE_CHAR { \
  uint32_t param = GET_32BIT_VALUE( \
    naie->bytecode.data, \
    ec->bytecode_offset + 4 \
  ); \
  if (ec->input_offset < ec->input.size && \
      ec->input.data[ ec->input_offset ] == param) \
  { \
    ++(ec->input_offset); \
    ec->bytecode_offset += instruction_size; \
  } else { \
    ec->failed = 1; \
  } \
}

#define HANDLE_RANGE { \
  uint32_t param1 = GET_32BIT_VALUE( \
    naie->bytecode.data, \
    ec->bytecode_offset + 4 \
  ); \
  uint32_t param2 = GET_32BIT_VALUE( \
    naie->bytecode.data, \
    ec->bytecode_offset + 8 \
  ); \
  if (ec->input_offset < ec->input.size && \
      ec->input.data[ ec->input_offset ] >= param1 && \
      ec->input.data[ ec->input_offset ] <= param2) \
  { \
    ++(ec->input_offset); \
    ec->bytecode_offset += instruction_size; \
  } else { \
    ec->failed = 1; \
  } \
}

#define HANDLE_MASKEDCHAR { \
  uint32_t param1 = GET_32BIT_VALUE( \
    naie->bytecode.data, \
    ec->bytecode_offset + 4 \
  ); \
  uint32_t param2 = GET_32BIT_VALUE( \
    naie->bytecode.data, \
    ec->bytecode_offset + 8 \
  ); \
  if (ec->input_offset < ec->input.size && \
      (ec->input.data[ ec->input_offset ] & param2) == param1) \
  { \
    ++(ec->input_offset); \
    ec->bytecode_offset += instruction_size; \
  } else { \
    ec->failed = 1; \
  } \
}

#define HANDLE_QUAD { \
  unsigned char* set = naie->bytecode.data + ec->bytecode_offset + 4; \
  if (ec->input_offset <= ec->input.size - 4 && \
      0 == memcmp(ec->input.data + ec->input_offset, set, 4)) \
  { \
    ++(ec->input_offset); \
    ec->bytecode_offset += instruction_size; \
  } else { \
    ec->failed = 1; \
  } \
}

#define HANDLE_SET { \
  unsigned char* set = naie->bytecode.data + ec->bytecode_offset + 4; \
  if (ec->input_offset < ec->input.size && \
      NAIE_DATA_IN_SET(set, ec->input.data[ ec->input_offset ])) \
  { \
    ++(ec->input_offset); \
    ec->bytecode_offset += instruction_size; \
  } else { \
    ec->failed = 1; \
  } \
}

#define HANDLE_TESTANY { \
  uint32_t param = GET_32BIT_VALUE( \
    naie->bytecode.data, \
    ec->bytecode_offset + 4 \
  ); \
  if (ec->input_offset < ec->input.size) { \
    ++(ec->input_offset); \
    ec->bytecode_offset += instruction_size; \
  } else { \
    ec->bytecode_offset = param; \
  } \
}

#define HANDLE_TESTCHAR { \
  uint32_t param1 = GET_32BIT_VALUE( \
    naie->bytecode.data, \
    ec->bytecode_offset + 4 \
  ); \
  uint32_t param2 = GET_32BIT_VALUE( \
    naie->bytecode.data, \
    ec->bytecode_offset + 4 \
  ); \
  if (ec->input_offset < ec->input.size && \
      ec->input.data[ ec->input_offset ] == param2) \
  { \
    ++(ec->input_offset); \
    ec->bytecode_offset += instruction_size; \
  } else { \
    ec->bytecode_offset = param1; \
  } \
}

#define HANDLE_TESTSET { \
  uint32_t param = GET_32BIT_VALUE( \
    naie->bytecode.data, \
    ec->bytecode_offset + 4 \
  ); \
  unsigned char* set = naie->bytecode.data + ec->bytecode_offset + 8; \
  if (ec->input_offset < ec->input.size && \
      NAIE_DATA_IN_SET(set, ec->input.data[ ec->input_offset ])) \
  { \
    ++(ec->input_offset); \
    ec->bytecode_offset += instruction_size; \
  } else { \
    ec->bytecode_offset = param; \
  } \
}

#define HANDLE_VAR { \
  unsigned char* value; \
  unsigned valuesize; \
  uint32_t param = GET_32BIT_VALUE( \
    naie->bytecode.data, \
    ec->bytecode_offset + 4 \
  ); \
  NAIG_CHECK(naie_variable(naie, ec, param, &value, &valuesize), PROPAGATE); \
  if (valuesize == 0) { \
    ec->failed = 1; \
  } else if (ec->input_offset + valuesize <= ec->input.size && \
             0 == memcmp(ec->input.data + ec->input_offset, value, valuesize)) \
  { \
    ec->input_offset += valuesize; \
    ec->bytecode_offset += instruction_size; \
  } else { \
    ec->failed = 1; \
  } \
}

#define HANDLE_CALL { \
  uint32_t param = GET_32BIT_VALUE( \
    naie->bytecode.data, \
    ec->bytecode_offset + 4 \
  ); \
  naie_stack_push( \
    &(ec->stack), \
    (naie_stackelt_t) { \
      .type = NAIE_STACK_CALL, \
      .address = ec->bytecode_offset + instruction_size, \
      .input_offset = ec->input_offset, \
      .input_length = ec->input.size, \
      .action_count = ec->actions.count \
    } \
  ); \
  ec->bytecode_offset = param; \
  if (ec->reg_ilen_set) { \
    ec->input.size = ec->reg_ilen; \
    ec->reg_ilen_set = 0; \
    ec->reg_ilen = 0; \
  } \
}

#define HANDLE_RET { \
  naie_stackelt_t elt; \
  if (naie_stack_size(&(ec->stack))) { \
    naie_stack_pop(&(ec->stack), &elt); \
    if (elt.type == NAIE_STACK_CALL) { \
      ec->bytecode_offset = elt.address; \
      ec->input.size = elt.input_length; \
      break; \
    } \
  } \
  return NAIG_ERR_BYTECODE; \
}

#define HANDLE_CATCH { \
  uint32_t param = GET_32BIT_VALUE( \
    naie->bytecode.data, \
    ec->bytecode_offset + 4 \
  ); \
  naie_stack_push( \
    &(ec->stack), \
    (naie_stackelt_t) { \
      .type = NAIE_STACK_CATCH, \
      .address = param, \
      .input_offset = ec->input_offset, \
      .input_length = ec->input.size, \
      .action_count = ec->actions.count \
    } \
  ); \
  ec->bytecode_offset = ec->bytecode_offset + instruction_size; \
}

#define HANDLE_COMMIT { \
  uint32_t param = GET_32BIT_VALUE( \
    naie->bytecode.data, \
    ec->bytecode_offset + 4 \
  ); \
  naie_stackelt_t elt; \
  if (naie_stack_size(&(ec->stack))) { \
    naie_stack_pop(&(ec->stack), &elt); \
    if (elt.type == NAIE_STACK_CATCH) { \
      ec->bytecode_offset = param; \
      break; \
    } \
  } \
  return NAIG_ERR_BYTECODE; \
}

#define HANDLE_BACKCOMMIT { \
  uint32_t param = GET_32BIT_VALUE( \
    naie->bytecode.data, \
    ec->bytecode_offset + 4 \
  ); \
  naie_stackelt_t elt; \
  if (naie_stack_size(&(ec->stack))) { \
    naie_stack_pop(&(ec->stack), &elt); \
    if (elt.action_count > ec->actions.count) { \
      return NAIG_ERR_BYTECODE; \
    } \
    if (elt.type == NAIE_STACK_CATCH) { \
      ec->bytecode_offset = param; \
      ec->input_offset = elt.input_offset; \
      ec->actions.count = elt.action_count; \
      break; \
    } \
  } \
  return NAIG_ERR_BYTECODE; \
}

#define HANDLE_PARTIALCOMMIT { \
  uint32_t param = GET_32BIT_VALUE( \
    naie->bytecode.data, \
    ec->bytecode_offset + 4 \
  ); \
  naie_stackelt_t elt; \
  if (0 == naie_stack_pop(&(ec->stack), &elt)) { \
    if (elt.type == NAIE_STACK_CATCH) { \
      elt.input_offset = ec->input_offset; \
      elt.action_count = ec->actions.count; \
      ec->bytecode_offset = param; \
      naie_stack_push(&(ec->stack), elt); \
      break; \
    } \
  } \
  return NAIG_ERR_BYTECODE; \
}
  
#define HANDLE_FAIL { \
  ec->failed = 1; \
}

#define HANDLE_FAILTWICE { \
  while (naie_stack_size(&(ec->stack))) { \
    naie_stackelt_t elt; \
    naie_stack_pop(&(ec->stack), &elt); \
    if (elt.type == NAIE_STACK_CATCH) { \
      break; \
    } \
  } \
  if (0 == naie_stack_size(&(ec->stack))) { \
    return NAIG_ERR_NOMATCH; \
  } \
  ec->failed = 1; \
}

#define HANDLE_OPENCAPTURE { \
  uint32_t param = GET_32BIT_VALUE( \
    naie->bytecode.data, \
    ec->bytecode_offset + 4 \
  ); \
  naie_actionlist_push(&(ec->actions), (naie_action_t){ \
    .type = NAIE_ACTION_OPENCAPTURE, \
    .slot = param, \
    .input_offset = ec->input_offset \
  }); \
}

#define HANDLE_CLOSECAPTURE { \
  uint32_t param = GET_32BIT_VALUE( \
    naie->bytecode.data, \
    ec->bytecode_offset + 4 \
  ); \
  naie_actionlist_push(&(ec->actions), (naie_action_t){ \
    .type = NAIE_ACTION_CLOSECAPTURE, \
    .slot = param, \
    .input_offset = ec->input_offset \
  }); \
}

#define HANDLE_COUNTER { \
  uint32_t param1 = GET_32BIT_VALUE( \
    naie->bytecode.data, \
    ec->bytecode_offset + 4 \
  ); \
  uint32_t param2 = GET_32BIT_VALUE( \
    naie->bytecode.data, \
    ec->bytecode_offset + 8 \
  ); \
  naie_register_push(&(ec->reg), (naie_regelt_t){ \
    .reg = param1, \
    .stacklen = ec->stack.count, \
    .value = param2 \
  }); \
}

#define HANDLE_CONDJUMP { \
  int i; \
  naie_regelt_t* elt; \
  uint32_t param1 = GET_32BIT_VALUE( \
    naie->bytecode.data, \
    ec->bytecode_offset + 4 \
  ); \
  uint32_t param2 = GET_32BIT_VALUE( \
    naie->bytecode.data, \
    ec->bytecode_offset + 8 \
  ); \
  if ((i = naie_register_indexof(&(ec->reg), (naie_regelt_t){ \
          .reg = param1, \
          .stacklen = ec->stack.count, \
        })) == -1) \
  { \
    return NAIG_ERR_BYTECODE; \
  } \
  elt = naie_register_getptr(&(ec->reg), i); \
  if (elt->value == 0) { \
    ec->bytecode_offset += instruction_size; \
  } else { \
    --(elt->value); \
    ec->bytecode_offset = param2; \
  } \
}

#define HANDLE_FAILURE { \
  while (naie_stack_size(&(ec->stack))) { \
    naie_stackelt_t elt; \
    naie_stack_pop(&(ec->stack), &elt); \
    if (elt.type == NAIE_STACK_CATCH) { \
      ec->bytecode_offset = elt.address; \
      ec->input_offset = elt.input_offset; \
      ec->actions.count = elt.action_count; \
    } \
  } \
  if (0 == naie_stack_size(&(ec->stack))) { \
    return NAIG_ERR_NOMATCH; \
  } \
}

#define HANDLE_INTRPCAPTURE { \
  uint32_t param1 = GET_32BIT_VALUE( \
    naie->bytecode.data, \
    ec->bytecode_offset + 4 \
  ); \
  uint32_t param2 = GET_32BIT_VALUE( \
    naie->bytecode.data, \
    ec->bytecode_offset + 8 \
  ); \
  unsigned char* value; \
  unsigned valuesize; \
  NAIG_CHECK(naie_variable(naie, ec, param1, &value, &valuesize), PROPAGATE); \
  if (valuesize == 0) { \
    RETURNERR(NAIG_ERR_INTRPCAPTURE); \
  } \
  switch (param2) { \
  case NAIG_INTRPCAPTURE_RUINT32: \
    if (valuesize <= 4) { \
      ec->reg_ilen = \
        (value[ 0 ] << ((valuesize-1) * 8)) | \
        ((valuesize > 1) ? (value[ 1 ] << ((valuesize-2) * 8)) : 0) | \
        ((valuesize > 2) ? (value[ 2 ] << ((valuesize-3) * 8)) : 0) | \
        ((valuesize > 3) ? (value[ 3 ]) : 0); \
      ec->reg_ilen += ec->input_offset; \
      if (ec->reg_ilen > ec->input.size) { \
        RETURNERR(NAIG_ERR_INTRPCAPTURE); \
      } \
      ec->reg_ilen_set = 1; \
    } else { \
      RETURNERR(NAIG_ERR_INTRPCAPTURE); \
    } \
  } \
  ec->bytecode_offset += instruction_size; \
}

#define HANDLE_TRAP { \
}


/**
 *
 */
NAIG_ERR_T naie_run
  (naie_t* naie, naie_ec_t* ec)
{
  uint32_t opcode;
  unsigned instruction_size;

  ASSERT(naie);
  ASSERT(ec);

  while (1) {
    if (ec->bytecode_offset > naie->bytecode.size) {
      RETURNERR(NAIG_ERR_OVERFLOW);
    }
    opcode = GET_32BIT_VALUE(naie->bytecode.data, ec->bytecode_offset);
    instruction_size = ((opcode >> 16) & 0xff) + 4;
    if (ec->bytecode_offset + instruction_size > naie->bytecode.size) {
      RETURNERR(NAIG_ERR_OVERFLOW);
    }
    if (naie->debugger) {
      NAIG_CHECK(naie->debugger(naie, ec, opcode, naie->debugarg), PROPAGATE);
    }
    switch (opcode) {
    case OPCODE_NOOP:            { HANDLE_NOOP }            break;
    case OPCODE_END:             { HANDLE_END }             break;
    case OPCODE_ANY:             { HANDLE_ANY }             break;
    case OPCODE_SKIP:            { HANDLE_SKIP }            break;
    case OPCODE_CHAR:            { HANDLE_CHAR }            break;
    case OPCODE_RANGE:           { HANDLE_RANGE }           break;
    case OPCODE_MASKEDCHAR:      { HANDLE_MASKEDCHAR }      break;
    case OPCODE_QUAD:            { HANDLE_QUAD }            break;
    case OPCODE_SET:             { HANDLE_SET }             break;
    case OPCODE_TESTANY:         { HANDLE_TESTANY }         break;
    case OPCODE_TESTCHAR:        { HANDLE_TESTCHAR }        break;
    case OPCODE_TESTSET:         { HANDLE_TESTSET }         break;
    case OPCODE_VAR:             { HANDLE_VAR }             break;
    case OPCODE_CALL:            { HANDLE_CALL }            break;
    case OPCODE_RET:             { HANDLE_RET }             break;
    case OPCODE_CATCH:           { HANDLE_CATCH }           break;
    case OPCODE_COMMIT:          { HANDLE_COMMIT }          break;
    case OPCODE_BACKCOMMIT:      { HANDLE_BACKCOMMIT }      break;
    case OPCODE_PARTIALCOMMIT:   { HANDLE_PARTIALCOMMIT }   break;
    case OPCODE_FAIL:            { HANDLE_FAIL }            break;
    case OPCODE_FAILTWICE:       { HANDLE_FAILTWICE }       break;
    case OPCODE_OPENCAPTURE:     { HANDLE_OPENCAPTURE }     break;
    case OPCODE_CLOSECAPTURE:    { HANDLE_CLOSECAPTURE }    break;
    case OPCODE_COUNTER:         { HANDLE_COUNTER }         break;
    case OPCODE_CONDJUMP:        { HANDLE_CONDJUMP }        break;
    case OPCODE_INTRPCAPTURE:    { HANDLE_INTRPCAPTURE }    break;
    case OPCODE_TRAP:            { HANDLE_TRAP }            break;
    default: RETURNERR(NAIG_ERR_BYTECODE);
    }
    if (ec->failed) {
      ec->failed = 0;
      HANDLE_FAILURE
      if (naie->debugger) {
        NAIG_CHECK(
          naie->debugger(naie, ec, OPCODE_FAILURE, naie->debugarg),
          PROPAGATE
        );
      }
    }
  }
}
