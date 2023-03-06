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

static
int naic_nsp_string_rule
  (naic_rulelist_t* list, unsigned index, naic_rule_t* rule, void* arg)
{
  DEBUGFUNCTION;
  ASSERT(list);
  ASSERT(rule);
  ASSERT(arg);

  (void)list;
  (void)index;

  NAIG_ERR_T e = naic_rule_string(rule, arg);

  return e.code;
}

static
int naic_nsp_string_children
  (naic_nsplist_t* list, unsigned index, naic_nsp_t** nsp, void* arg)
{
  DEBUGFUNCTION;
  ASSERT(list);
  ASSERT(nsp);
  ASSERT(arg);

  tdt_t* string = arg;
  (void)list;
  (void)index;

  td_printf(string, "  namespace_start %s\n", (*nsp)->name);
  NAIG_ERR_T e = naic_nsp_string(*nsp, arg);
  td_printf(string, "  namespace_stop %s\n", (*nsp)->name);

  return e.code;
}

/**
 *
 */
NAIG_ERR_T naic_nsp_string
  (naic_nsp_t* nsp, tdt_t* string)
{
  DEBUGFUNCTION;
  ASSERT(nsp);
  ASSERT(string);

  naic_instrlist_iterate(
    &(nsp->instructions),
    naic_rule_string_instr,
    string
  );
  naic_rulelist_iterate(&(nsp->rules), naic_nsp_string_rule, string);
  naic_nsplist_iterate(&(nsp->children), naic_nsp_string_children, string);

  return NAIG_OK;
}
