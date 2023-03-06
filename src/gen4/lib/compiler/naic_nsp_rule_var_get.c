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

struct naic_nsp_rule_var_helper
{
  char* var;
  unsigned slot;
};

static
int naic_nsp_rule_var_compare_rule
  (naic_instrlist_t* list, unsigned i, naic_instr_t* instr, void* ptr)
{
  struct naic_nsp_rule_var_helper* h = ptr;
  (void)list;
  (void)i;

  if (instr->instr == OPCODE_OPENCAPTURE) {
    if (instr->label && 0 == strcmp(h->var, instr->label)) {
      h->slot = instr->params.ints[ 0 ];
      return ~0;
    }
  }
  return 0;
}

static
int naic_nsp_rule_var_get_rule
  (naic_rule_t* rule, char* name, unsigned* slot)
{
  struct naic_nsp_rule_var_helper h = { .var = name };
  int e;

  e = naic_instrlist_iterate(
    &(rule->instructions),
    naic_nsp_rule_var_compare_rule,
    &h
  );
  if (e) {
    *slot = h.slot;
    return 0;
  }
  return ~0;
}

static
int naic_nsp_var_get
  (naic_rulelist_t* list, unsigned i, naic_rule_t* rule, void* ptr)
{
  struct naic_nsp_rule_var_helper* h = ptr;
  (void)list;
  (void)i;

  return naic_nsp_rule_var_get_rule(rule, h->var, &(h->slot));
}

/**
 *
 */
NAIG_ERR_T naic_nsp_rule_var_get
  (naic_nsp_t* nsp, naic_rule_t* rule, char* name, unsigned* slot)
{
  struct naic_nsp_rule_var_helper h = { .var = name };

  if (0 == strcmp(name, "_")) {
    *slot = NAIC_VARIABLE_DEFAULT;
    return NAIG_OK;
  }
  if (name[ 0 ] >= '0' && name[ 0 ] <= '9') {
    *slot = atoi(name);
    return NAIG_OK;
  }
  if (naic_nsp_rule_var_get_rule(rule, name, slot) == 0) {
    return NAIG_OK;
  }
  if (naic_rulelist_iterate(&(nsp->rules), naic_nsp_var_get, &h) == 0) {
    *slot = h.slot;
    return NAIG_OK;
  }
  RETURNERR(NAIG_ERR_NOTFOUND);
}
