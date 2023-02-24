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

static
int naic_rule_string_instr
  (naic_instrlist_t* list, unsigned index, naic_instr_t* instr, void* arg)
{
  ASSERT(list);
  ASSERT(instr);
  ASSERT(arg);

  tdt_t* string = arg;
  (void)list;
  (void)index;

  switch (instr->instr) {
  case OPCODE_LABEL:
    td_printf(string, "%s:\n", instr->params.label.string);
    break;
  case OPCODE_CALL:
    td_printf(string, "  call %s\n", instr->params.label.string);
    break;
  case OPCODE_CATCH:
    td_printf(string, "  catch %s\n", instr->params.label.string);
    break;
  case OPCODE_COMMIT:
    td_printf(string, "  commit %s\n", instr->params.label.string);
    break;
  case OPCODE_OPENCAPTURE:
    td_printf(string, "  opencapture %u\n", instr->params.ints[ 0 ]);
    break;
  case OPCODE_CLOSECAPTURE:
    td_printf(string, "  closecapture %u\n", instr->params.ints[ 0 ]);
    break;
  case OPCODE_RET:
    td_printf(string, "  ret\n");
    break;
  default:
    td_printf(string, "-- unknown opcode %u\n", instr->instr);
    break;
  }
  return 0;
}

/**
 * 
 */
NAIG_ERR_T naic_rule_string
  (naic_rule_t* rule, tdt_t* string)
{
  ASSERT(rule);
  ASSERT(string);

  naic_instrlist_iterate(
    &(rule->instructions),
    naic_rule_string_instr,
    string
  );
  td_printf(string, "\n");

  return NAIG_OK;
}
