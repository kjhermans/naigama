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
 * Returns the value of a variable.
 */
NAIG_ERR_T naie_variable
  (
    naie_engine_t* engine,
    const unsigned char* data,
    uint32_t slot,
    unsigned char** value,
    unsigned* valuesize
  )
{
  unsigned i = engine->actions.count;
  naie_action_t* c = &(engine->actions.entries[ i ]);
  unsigned start, stop;
  int stopfound = 0, startfound = 0;
  unsigned stacklength = naie_stack_call_size(engine);

  while (i > 0) {
    --i;
    c = &(engine->actions.entries[ i ]);
    if (slot == NAIG_SLOT_DEFAULT
        || (c->slot == slot && stacklength == c->stacklength))
    {
      if (c->action == NAIG_ACTION_OPENCAPTURE && stopfound) {
        start = c->inputpos;
        startfound = 1;
        break;
      } else if (c->action == NAIG_ACTION_CLOSECAPTURE) {
        stop = c->inputpos;
        stopfound = 1;
        slot = c->slot;
        stacklength = c->stacklength;
      }
    }
  }
  if (startfound && stopfound && stop >= start) {
    *value = (unsigned char*)data + start;
    *valuesize = stop - start;
    return NAIG_OK;
  }
#ifdef _DEBUG
  fprintf(stderr,
    "Attempt to retrieve variable for slot %u at stack size %u failed.\n"
    , slot
    , naie_stack_call_size(engine)
  );
#endif
  RETURNERR(NAIG_ERR_VARIABLE);
}
