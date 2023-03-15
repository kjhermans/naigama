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

#include <naigama/naigama/naig_type_resobj.h>

#include "naia_private.h"

#include <naigama/assembler/naig_slotmap_assembly.h>

/**
 * Assembler second pass.
 * During the second pass, the assembler writes out all the instructions
 * as binary bytecode to an internal buffer.
 *
 * \param naia  Initialized assembler structure.
 * \param obj   Parse node.
 * \returns     NAIG_OK on success, and a NAIG_ERR_T code on failure.
 */
NAIG_ERR_T naia_sp
  (naia_t* naia, naig_resobj_t* obj)
{
  DEBUGFUNCTION; 
  ASSERT(naia != NULL);
  ASSERT(obj != NULL);
  ASSERT(obj->nchildren);

  naia->offset = 0;
  for (unsigned i=0; i < obj->nchildren; i++) {
    switch (obj->children[ i ]->type) {
    case SLOTMAP_INSTRUCTION_RULEINSTR:
      NAIG_CHECK(naia_sp_instruction(naia, obj->children[ i ]), PROPAGATE);
      break;
    case SLOTMAP_INSTRUCTION_LABELDEF:
      break;
    case SLOTMAP_INSTRUCTION_NAMESPACEDEF:
      break;
    }
  }
  return NAIG_OK;
}
