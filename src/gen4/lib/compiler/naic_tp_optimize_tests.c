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

#include <naigama/naigama/naig_instructions.h>

#include "naic_private.h"

struct naic_tp_test_state
{
  int seen_catch;
  int seen_matcher;
};

static
int naic_tp_instr_examine_test
  (naic_instrlist_t* list, unsigned i, naic_instr_t* instr, void* ptr)
{
  (void)list;
  (void)i;
  struct naic_tp_test_state* s = ptr;

  if (instr->instr == OPCODE_CATCH
      && s->seen_catch == 0
      && s->seen_matcher == 0)
  {
    s->seen_catch = 1;
  } else if ((instr->instr == OPCODE_ANY
              || instr->instr == OPCODE_CHAR
              || instr->instr == OPCODE_SET)
             && s->seen_catch != 0
             && s->seen_matcher == 0)
  {
    s->seen_matcher = 1;
  } else if ((instr->instr == OPCODE_ANY
              || instr->instr == OPCODE_CHAR
              || instr->instr == OPCODE_SET)
             && s->seen_catch != 0
             && s->seen_matcher != 0)
  {
    naic_instr_t tmp;
    naic_instr_t* instr0 = naic_instrlist_getptr(list, i-2); ASSERT(instr0);
    naic_instr_t* instr1 = naic_instrlist_getptr(list, i-1); ASSERT(instr1);
    tmp = *instr0;
    *instr0 = *instr1;
    *instr1 = tmp;
    instr0->label = strdup(instr1->label);
    switch (instr0->instr) {
    case OPCODE_ANY:
      instr0->instr = OPCODE_TESTANY;
      break;
    case OPCODE_CHAR:
      instr0->instr = OPCODE_TESTCHAR;
      break;
    case OPCODE_SET:
      instr0->instr = OPCODE_TESTSET;
      break;
    }
    s->seen_catch = 0;
    s->seen_matcher = 0;
  } else {
    s->seen_catch = 0;
    s->seen_matcher = 0;
  }

  return 0;
}

static
int naic_tp_rule_optimize_tests
  (naic_rulelist_t* list, unsigned i, naic_rule_t* rule, void* ptr)
{
  (void)i;
  (void)list;
  (void)ptr;
  struct naic_tp_test_state s = { 0 };

  return naic_instrlist_iterate(
    &(rule->instructions),
    naic_tp_instr_examine_test,
    &s
  );
}

static
int naic_tp_nsp_optimize_tests
  (naic_t* naic, naic_nsp_t* nsp)
{
  (void)naic;
  int e;
  unsigned charcount = 0;

  e = naic_instrlist_iterate(
    &(nsp->instructions),
    naic_tp_instr_examine_test,
    &charcount
  );
  if (e) { return e; }
  e = naic_rulelist_iterate(
    &(nsp->rules),
    naic_tp_rule_optimize_tests,
    0
  );

  return e;
}

/**
 *
 */
NAIG_ERR_T naic_tp_optimize_tests
  (naic_t* naic)
{
  naic_nsp_t* nsp = &(naic->namespace.top);
  int e;

  if ((e = naic_tp_nsp_optimize_tests(naic, nsp)) != 0) {
    RETURNERR(NAIG_ERR_REFERENCE);
  }

  return NAIG_OK;
}
