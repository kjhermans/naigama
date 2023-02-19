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

/**
 * This file implements the interface with the
 * previous generation's parsing engine.
 *
 * This is somewhat hacky code. However, it's needed
 * to preserve purity of implementation: only this single
 * file needs to be specially compiled in order to
 * only use the previous generation engine for parsing
 * the grammar, and present the capture list result to
 * the caller using a current generation (independent)
 * data structure. Since this may be problematic because
 * the previous generation uses abstractions in source code
 * similar to this generation's, in order to prevent
 * namespace confustion for the (C) compiler, this file
 * exists.
 */

#define ARRAY_EQUALS(a,b) (0==memcmp(&a,&b,sizeof(a)))

#include <naigama/engine/naie.h>
#include "../../include/naigama/prevgen/naip.h"

MAKE_ARRAY_CODE(naip_action_t, naip_actionlist_)

/**
 *
 */
int naip_parse
  (
    naip_t* naip,
    unsigned char* bytecode,
    unsigned bytecode_size,
    char* grammar,
    naip_actionlist_t* actions
  )
{
  naie_engine_t engine;
  naio_result_t result;

  memset(naip, 0, sizeof(*naip));
  naip_actionlist_init(actions);
  {
    NAIG_ERR_T e = naie_engine_init(&engine, bytecode, bytecode_size);
    if (e.code) {
      naip->error_code = e.code;
      naip->error_offset = engine.input_pos;
      return e.code;
    }
  }
  {
    NAIG_ERR_T e = naie_engine_run(&engine, (unsigned char*)grammar, strlen(grammar), &result);
    if (e.code) {
      naip->error_code = e.code;
      naip->error_offset = engine.input_pos;
      return e.code;
    }
  }
  {
    for (unsigned i=0; i < result.count; i++) {
      naip_actionlist_push(actions, (naip_action_t){
        .type         = result.actions[ i ].action,
        .slot         = result.actions[ i ].slot,
        .input_offset = result.actions[ i ].start,
        .length       = result.actions[ i ].length
      });
    }
  }

  return 0;
}
