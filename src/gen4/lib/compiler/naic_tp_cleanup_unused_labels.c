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

struct naic_label_cleanup_helper
{
  char* label;
  unsigned referencecount;
};

static
int naic_tp_instr_examine_reference
  (naic_instrlist_t* list, unsigned i, naic_instr_t* instr, void* arg)
{
  struct naic_label_cleanup_helper* h = arg;
  (void)i;
  (void)list;

  switch (instr->instr) {
  case OPCODE_CALL:
  case OPCODE_CATCH:
  case OPCODE_COMMIT:
  case OPCODE_PARTIALCOMMIT:
  case OPCODE_BACKCOMMIT:
  case OPCODE_CONDJUMP:
  case OPCODE_TESTANY:
  case OPCODE_TESTCHAR:
  case OPCODE_TESTSET:
    if (0 == strcmp(h->label, instr->label)) {
      ++(h->referencecount);
    }
  }
  return 0;
}

static
int naic_tp_rule_examine_reference
  (naic_rulelist_t* list, unsigned i, naic_rule_t* rule, void* arg)
{
  struct naic_label_cleanup_helper* h = arg;
  (void)i;
  (void)list;

  return naic_instrlist_iterate(
    &(rule->instructions),
    naic_tp_instr_examine_reference,
    h
  );
}

static
int naic_tp_nsp_cleanup_references
  (naic_nsp_t* nsp, char* label, int* remove)
{
  struct naic_label_cleanup_helper h = { .label = label, .referencecount = 0 };
  int e;

  *remove = 0;
  e = naic_instrlist_iterate(
    &(nsp->instructions),
    naic_tp_instr_examine_reference,
    &h
  );
  if (e) { return e; }
  e = naic_rulelist_iterate(
    &(nsp->rules),
    naic_tp_rule_examine_reference,
    &h
  );
  if (e) { return e; }

  if (h.referencecount == 0) {
    *remove = 1;
  }
  return 0;
}

static
int naic_tp_instr_examine_label
  (naic_instrlist_t* list, unsigned i, naic_instr_t* instr, void* ptr)
{
  naic_t* naic = ptr;
  int remove = 0;
  (void)list;
  (void)i;

  if (instr->instr == OPCODE_LABEL) {
    naic_nsp_t* nsp = &(naic->namespace.top);
    naic_tp_nsp_cleanup_references(nsp, instr->label, &remove);
    if (remove) {
      DEBUGMSG("Removing label '%s'\n", instr->label);
      free(instr->label);
      instr->instr = OPCODE_NONE;
    }
  }
  return 0;
}

static
int naic_tp_rule_examine_label
  (naic_rulelist_t* list, unsigned i, naic_rule_t* rule, void* ptr)
{
  int e;
  naic_t* naic = ptr;
  (void)i;
  (void)list;

  e = naic_instrlist_iterate(
    &(rule->instructions),
    naic_tp_instr_examine_label,
    naic
  );
  return e;
}

static
int naic_tp_nsp_cleanup_labels
  (naic_t* naic, naic_nsp_t* nsp)
{
  int e;

  e = naic_instrlist_iterate(
    &(nsp->instructions),
    naic_tp_instr_examine_label,
    naic
  );
  if (e) { return e; }
  e = naic_rulelist_iterate(
    &(nsp->rules),
    naic_tp_rule_examine_label,
    naic
  );

  return e;
}

/**
 *
 */
NAIG_ERR_T naic_tp_cleanup_unused_labels
  (naic_t* naic)
{
  naic_nsp_t* nsp = &(naic->namespace.top);
  int e;

  if ((e = naic_tp_nsp_cleanup_labels(naic, nsp)) != 0) {
    td_printf(&(naic->errorstr), "At cleaning up unused labels.");
    RETURNERR(NAIG_ERR_REFERENCE);
  }

  return NAIG_OK;
}
