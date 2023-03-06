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

#include "naic_private.h"

#include <naigama/naigama/naig_instructions.h>
#include <naigama/parser/naip.h>
#include <naigama/naigama/naig_functions.h>
#include <naigama/util/octal.h>

static
unsigned naic_set_char
  (char* chr)
{
  switch (*chr) {
  case '\\':
    ++chr;
    switch (*chr) {
    case 'n':
      return (unsigned)'\n';
    case 'r':
      return (unsigned)'\r';
    case 't':
      return (unsigned)'\t';
    case 'v':
      return (unsigned)'\v';
    case '\\':
      return (unsigned)'\\';
    case ']':
      return (unsigned)']';
    case '0': case '1': case '2': case '3': case '4':
    case '5': case '6': case '7': case '8': case '9':
      return octal(chr[0], chr[1], chr[2]);
    }
    __attribute__((fallthrough));
  default:
    return (unsigned)(*chr);
  }
}

NAIG_ERR_T naic_sp_rule_matcher_set_range
  (naic_rule_t* rule, uint8_t from, uint8_t until, int invert)
{
  (void)rule; (void)from; (void)until; (void)invert;
  TODO("Implement");
  return NAIG_OK;
}

NAIG_ERR_T naic_sp_rule_matcher_set_bits
  (uint8_t* set, uint8_t from, uint8_t until, int invert)
{
  for (; from <= until; from++) {
    if (invert) {
      NAIC_SET_BIT_UNSET(set, from);
    } else {
      NAIC_SET_BIT_SET(set, from);
    }
  }
  return NAIG_OK;
}

NAIG_ERR_T naic_sp_rule_matcher_set_fromuntil
  (
    naic_t* naic,
    naic_rule_t* rule,
    uint8_t* set,
    uint8_t from,
    uint8_t until,
    int invert
  )
{
  if (naic->flags & NAIC_FLG_SETSASRANGES) {
    NAIG_CHECK(
      naic_sp_rule_matcher_set_range(rule, from, until, invert),
      PROPAGATE
    );
  } else {
    NAIG_CHECK(
      naic_sp_rule_matcher_set_bits(set, from, until, invert),
      PROPAGATE
    );
  }
  return NAIG_OK;
}

/**
 *
 */
NAIG_ERR_T naic_sp_rule_matcher_set
  (naic_t* naic, naic_nsp_t* nsp, naic_rule_t* rule, naig_resobj_t* obj)
{
  DEBUGFUNCTION;
  ASSERT(naic != NULL);
  ASSERT(nsp != NULL);
  ASSERT(rule != NULL);
  ASSERT(obj != NULL);
  ASSERT(obj->nchildren);

  int invert = 0;
  naic_instr_t instr = {
    .instr = OPCODE_SET
  };
  (void)nsp;

  if (naig_result_object_query(obj, 1, SLOTMAP_SETNOT_, 0)) {
    memset(instr.params.set, 0xff, sizeof(instr.params.set));
    invert = 1;
  } else {
    memset(instr.params.set, 0, sizeof(instr.params.set));
  }

  for (unsigned i=0; i < obj->nchildren; i++) {
    unsigned from;
    unsigned until;
    if (obj->children[ i ]->type == SLOTMAP_SET_NRTV) {
      from = naic_set_char(obj->children[ i ]->string);
      until = naic_set_char(obj->children[ ++i ]->string);
    } else if (obj->children[ i ]->type == SLOTMAP_SET_NRTV_2) {
      from = naic_set_char(obj->children[ i ]->string);
      until = from;
    } else {
      continue;
    }
    NAIG_CHECK(
      naic_sp_rule_matcher_set_fromuntil(
        naic, rule, instr.params.set, from, until, invert
      ),
      PROPAGATE
    );
  }
  if (naic->flags & NAIC_FLG_SETSASRANGES) {
    TODO("Implement");
  } else {
    naic_instrlist_push(&(rule->instructions), instr);
  }

  return NAIG_OK;
}
