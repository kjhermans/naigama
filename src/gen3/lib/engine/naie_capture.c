/**
 * This file is part of Oroszlan, a parsing and scripting environment

Copyright (c) 2022, Kees-Jan Hermans <kees.jan.hermans@gmail.com>
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
 * \param capture Callback for each capture. Args:
 *        - capture index (nth capture)
 *        - pointer to the start of the capture in the input
 *        - length of capture
 *        - capture slot type
 *        - pointer argument provided by the caller
 */
NAIG_ERR_T naie_capture
  (
    naie_engine_t* engine,
    unsigned char* input,
    unsigned input_length,
    int(*capture)(unsigned, unsigned char*, unsigned, unsigned, void*),
    void* ptr
  )
{
  unsigned i;
  naio_result_t result;

  NAIG_CHECK(naie_engine_run(engine, input, input_length, &result));
  for (i=0; i < result.count; i++) {
    if (result.actions[ i ].action == NAIG_ACTION_OPENCAPTURE) {
      if (capture(
            i,
            input + result.actions[ i ].start,
            result.actions[ i ].length, 
            result.actions[ i ].slot, 
            ptr))
      {
//.. should be error
        break;
      }
    }
  }
  naie_result_free(&result);
  return NAIG_OK;
}
