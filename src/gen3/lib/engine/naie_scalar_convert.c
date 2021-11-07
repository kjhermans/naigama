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

#include "naie_private.h"

/**
 *
 */
NAIG_ERR_T naie_scalar_convert
  (uint32_t* instr, naie_scalar_t* scalar)
{
  scalar->type = GET_32BIT_VALUE(&(instr[ 0 ]), 0);
  switch (scalar->type) {
  case NAIE_SCALAR_TYPE_VOID:
    return NAIG_OK;
  case NAIE_SCALAR_TYPE_BOOLEAN:
    scalar->value._int = (instr[ 1 ] ? 1 : 0);
    return NAIG_OK;
  case NAIE_SCALAR_TYPE_STRING:
  case NAIE_SCALAR_TYPE_UNSIGNED:
    scalar->value._unsigned = GET_32BIT_NWO(&(instr[ 1 ]), 0);
    return NAIG_OK;
  case NAIE_SCALAR_TYPE_INT:
    scalar->value._int = GET_32BIT_NWO(&(instr[ 1 ]), 0);
    return NAIG_OK;
  case NAIE_SCALAR_TYPE_FLOAT:
    TODO("Create float conversion");
    break;
  case NAIE_SCALAR_TYPE_TYPEDLIST:
    TODO("Create typedlist conversion");
    break;
  case NAIE_SCALAR_TYPE_FREELIST:
    TODO("Create freelist conversion");
    break;
  case NAIE_SCALAR_TYPE_STRINGMAP:
    TODO("Create stringmap conversion");
    break;
  case NAIE_SCALAR_TYPE_REFERENCE:
    scalar->value._int = GET_32BIT_NWO(&(instr[ 1 ]), 0);
    return NAIG_OK;
  case NAIE_SCALAR_TYPE_STACKRETURN:
    return NAIG_OK;
  }
  return NAIG_ERR_SCALARTYPE;
}
