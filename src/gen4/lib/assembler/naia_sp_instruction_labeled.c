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

#include "naia_private.h"

#include <naigama/naigama/naig_instructions.h>

/**
 * Writes a label as argument to the bytecode buffer.
 * The label will be resolved to an offset.
 * There is a special label __NEXT__ will automatically be resolved
 * to the offset directly beyond the current instruction
 * (which is why the opcode is needed as an argument to this function,
 * as opcodes denote their own instruction length).
 *
 * \param naia          Initialized assembler structure.
 * \param opcode        The opcode of the instruction.
 * \param label         The string containing the label.
 * \returns             NAIG_OK on success, and a NAIG_ERR_T code on failure.
 */
NAIG_ERR_T naia_sp_instruction_labeled
  (naia_t* naia, uint32_t opcode, char* label)
{
  unsigned offset;
  uint32_t param;
  unsigned instrsize = NAIA_INSTR_SIZE(opcode);

  if (0 == strcmp(label, "__NEXT__")) {
    offset = naia->offset + instrsize;
  } else if (str2int_map_get(&(naia->labelmap), label, &offset) != 0) {
    td_printf(&(naia->errorstr), "Could not resolve label '%s'\n", label);
    RETURNERR(NAIG_ERR_LABEL);
  }
  param = htobe32(offset);
  td_append(&(naia->output.string), &param, sizeof(param));

  return NAIG_OK;
}
