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

#include <naigama/parser/naip.h>
#include <naigama/naigama/naig_type_resobj.h>
#include <naigama/naigama/naig_functions.h>
#include <naigama/naigama/naig_instructions.h>

/**
 * Topmost library function.
 */
NAIG_ERR_T naic_compile
  (naic_t* naic, char* path)
{
  DEBUGFUNCTION;
  ASSERT(naic);
  ASSERT(path);

  NAIG_CHECK(naic_nsp_init(&(naic->namespace.top), "__top"), PROPAGATE);
  naic->namespace.current = &(naic->namespace.top);
  NAIG_CHECK(naic_nsp_parse(naic, &(naic->namespace.top), path, 0), PROPAGATE);
  NAIG_CHECK(naic_sp(naic, &(naic->namespace.top)), PROPAGATE);

  if (naic_rulelist_has(&(naic->namespace.top.rules),
                        (naic_rule_t){ .name = "__main" }))
  {
    naic_instrlist_ins(
      &(naic->namespace.top.instructions),
      0,
      (naic_instr_t){
        .instr = OPCODE_END,
        .params.ints[ 0 ] = 0
      }
    );
    naic_instrlist_ins(
      &(naic->namespace.top.instructions),
      0,
      (naic_instr_t){
        .instr = OPCODE_CALL,
        .label = strdup("__main")
      }
    );
  } else if (!naic_rulelist_size(&(naic->namespace.top.rules))) {
    td_printf(&(naic->errorstr), "Warning: no instructions were emitted\n");
  } else {
    naic_rule_t* rule = naic_rulelist_getptr(&(naic->namespace.top.rules), 0);
    naic_instrlist_ins(
      &(naic->namespace.top.instructions),
      0,
      (naic_instr_t){
        .instr = OPCODE_END,
        .params.ints[ 0 ] = 0
      }
    );
    naic_instrlist_ins(
      &(naic->namespace.top.instructions),
      0,
      (naic_instr_t){
        .instr = OPCODE_CALL,
        .label = strdup(rule->name)
      }
    );
  }

  NAIG_CHECK(naic_tp(naic), PROPAGATE);

  return NAIG_OK;
}
