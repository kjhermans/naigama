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

#include <naigama/engine/naie.h>
#include <naigama/util/absorb_file.h>

#include "naid_private.h"
#include "naid_bytecode.h"

/**
 *
 */
NAIG_ERR_T naid_parse
  (naid_t* naid, char* path)
{
  DEBUGFUNCTION;
  ASSERT(naid);
  ASSERT(path);

  naie_t naie = { 0 };
  naie_ec_t ec = { 0 };
  unsigned char* input;
  unsigned input_length;

  if (absorb_file(path, &input, &input_length)) {
    td_printf(&(naid->errorstr), "Could not absorb file '%s'\n", path);
    RETURNERR(NAIG_ERR_NOTFOUND);
  }
  NAIG_CHECK(naie_init(&naie, bytecode, sizeof(bytecode)), PROPAGATE);
  NAIG_CHECK(naie_ec_init(&ec, input, input_length), PROPAGATE);
  NAIG_CHECK(naie_run(&naie, &ec), PROPAGATE);

  naig_resobj_t* obj = naig_result_object(input, input_length, &(ec.actions));
  if (obj == NULL) {
    RETURNERR(NAIG_ERR_PARSER);
  }
  naid->parsetree = obj;
  return NAIG_OK;
}
