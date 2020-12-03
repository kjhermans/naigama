/**
 * This file is part of Naigama, a parser engine.

Copyright (c) 2020, Kees-Jan Hermans <kees.jan.hermans@gmail.com>
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the <organization> nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
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

/**
 *
 */
NAIG_ERR_T naic_compile_expr_literal
  (naic_t* naic, naie_resobj_t* lit)
{
  char stringlabel[ 64 ];

  switch (lit->children[ 0 ]->type) {
  case SLOT_INTLITERAL:
    NAIC_WRITE("  __s:push %s\n" , lit->children[ 0 ]->string);
    break;
  case SLOT_STRINGLITERAL_NRTV:
    snprintf(stringlabel, sizeof(stringlabel), "__STRING_%u", ++(naic->labelcount));
    NAIC_WRITE("  __s:push __string %s\n", stringlabel);
    NAIC_RESERVE("%s:\n  __s:string '%s'\n", stringlabel, lit->children[ 0 ]->string);
    break;
  }
  return NAIG_OK;
}
