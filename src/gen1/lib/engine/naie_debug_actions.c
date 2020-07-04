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

#include <inttypes.h>

#include "naie_private.h"

static
char* naie_debug_action_string
  (unsigned action)
{
  switch (action) {
  case NAIG_ACTION_OPENCAPTURE:
    return "Co";
  case NAIG_ACTION_CLOSECAPTURE:
    return "Cc";
  case NAIG_ACTION_DELETE:
    return "Rx";
  case NAIG_ACTION_REPLACE_CHAR:
    return "Rc";
  case NAIG_ACTION_REPLACE_QUAD:
    return "Rq";
  default:
    return "!!";
  }
}

/**
 *
 */
void naie_debug_actions
  (naie_engine_t* engine)
{
  unsigned i;

  for (i=0; i < engine->actions.size; i++) {
    fprintf(stderr,
      "Action #%u; act=%s, slot=%u, pos=%u, sl=%u, int=%"PRIu64"\n"
      , i
      , naie_debug_action_string(engine->actions.entries[ i ].action)
      , engine->actions.entries[ i ].slot
      , engine->actions.entries[ i ].inputpos
      , engine->actions.entries[ i ].stacklength
      , engine->actions.entries[ i ].intvalue
    );
  }
}
