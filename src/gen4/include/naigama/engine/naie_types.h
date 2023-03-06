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

#ifndef _NAIE_GEN4_TYPES_H_
#define _NAIE_GEN4_TYPES_H_

#include <naigama/util/td.h>

#include "naie_type_stack.h"
#include "naie_type_actions.h"
#include "naie_type_register.h"

/**
 * Engine execution context.
 * This structure is not re-entrant.
 */
typedef struct
{
  tdt_t                 input;
  unsigned              input_offset;
  unsigned              bytecode_offset;
  int                   failed;
  int                   endcode;
  naie_stack_t          stack;
  naie_actionlist_t     actions;
  naie_register_t       reg;
  unsigned              reg_ilen;
  int                   reg_ilen_set;
}
naie_ec_t;

/**
 * Static engine context.
 * This structure is re-entrant / read-only after set-up.
 */
typedef struct naie naie_t;

struct naie
{
  tdt_t                 bytecode;
  //.. slotmap
  //.. labelmap
  NAIG_ERR_T          (*debugger)(naie_t*,naie_ec_t*,uint32_t,void*);
  void*                 debugarg;
};

#endif // defined _NAIE_GEN4_TYPES_H_ ?
