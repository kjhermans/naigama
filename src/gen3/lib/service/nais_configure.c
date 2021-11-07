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

#include "nais_private.h"

#include <naigama/service/nais_bytecode.h>
#include <naigama/util/util_functions.h>

static
unsigned char nais_json_bytecode[] = {
  NAIS_JSON_BYTECODE
};

/**
 *
 */
NAIG_ERR_T nais_configure
  (nais_t* nais)
{
  char path[ 256 ];
  unsigned char* buf;
  unsigned buflen;
  naie_engine_t e;
  naio_result_t r;
  naio_resobj_t* o;

  snprintf(path, sizeof(path), "%s/etc/nais.conf", nais->root);
  if (absorb_file(path, &buf, &buflen)) {
    return NAIG_ERR_READ;
  }
  CHECK(
    naie_engine_init(
      &e,
      nais_json_bytecode,
      sizeof(nais_json_bytecode),
      buf,
      buflen
    )
  );
  CHECK(naie_engine_run(&e, &r));
  o = naio_result_object(buf, buflen, &r);
  CHECK(nais_configure_side(nais, o, 0));
  CHECK(nais_configure_side(nais, o, 1));
  return NAIG_OK;
}
