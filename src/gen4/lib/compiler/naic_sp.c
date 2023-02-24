/**
 * This file is part of Oroszlan, a parsing and scripting environment

Copyright (c) 2021, Kees-Jan Hermans <kees.jan.hermans@gmail.com>
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

struct naic_sp_rule_helper
{
  naic_t* naic;
  naic_nsp_t* nsp;
};

static
int naic_sp_rule
  (naic_rulelist_t* list, unsigned index, naic_rule_t* rule, void* arg)
{
  ASSERT(list);
  ASSERT(rule);
  ASSERT(arg);

  struct naic_sp_rule_helper* h = arg;
  NAIG_ERR_T e = naic_sp_rule_compile(h->naic, h->nsp, rule);
  (void)list;
  (void)index;

  if (e.code) {
    td_printf(&(h->naic->errorstr), "Compile error in rule '%s'\n", rule->name);
    return e.code;
  }
  return 0;
}

/**
 *
 */
NAIG_ERR_T naic_sp
  (naic_t* naic, naic_nsp_t* nsp)
{
  ASSERT(naic);
  ASSERT(nsp);

  struct naic_sp_rule_helper h = { naic, nsp };

  naic_rulelist_iterate(&(nsp->rules), naic_sp_rule, &h);
  return NAIG_OK;
}
