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

#include <ctype.h>

#include <naigama/engine/naie.h>

/**
 * Prints to stderr the engine result (action list).
 */
void naie_result_debug
  (naie_engine_t* engine)
{
  unsigned i;

  for (i=0; i < engine->actions.count; i++) {
    switch (engine->actions.entries[ i ].action) {
    case NAIG_ACTION_OPENCAPTURE:
      fprintf(stderr, "Action #%u: opencapture slot %u, %u\n"
        , i
        , engine->actions.entries[ i ].slot
        , engine->actions.entries[ i ].inputpos
      );
      break;
    case NAIG_ACTION_CLOSECAPTURE:
      fprintf(stderr, "Action #%u: closecapture slot %u, %u\n"
        , i
        , engine->actions.entries[ i ].slot
        , engine->actions.entries[ i ].inputpos
      );
      break;
    case NAIG_ACTION_DELETE:
      fprintf(stderr, "Action #%u: delete slot %u, %u\n"
        , i
        , engine->actions.entries[ i ].slot
        , engine->actions.entries[ i ].inputpos
      );
      break;
    case NAIG_ACTION_REPLACE_CHAR:
      fprintf(stderr, "Action #%u: insert slot %u, at %u char %.2x\n"
        , i
        , engine->actions.entries[ i ].slot
        , engine->actions.entries[ i ].inputpos
        , (unsigned)(engine->actions.entries[ i ].intvalue)
      );
      break;
    case NAIG_ACTION_REPLACE_QUAD:
      fprintf(stderr, "Action #%u: insert slot %u, at %u quad %.8x\n"
        , i
        , engine->actions.entries[ i ].slot
        , engine->actions.entries[ i ].inputpos
        , (unsigned)(engine->actions.entries[ i ].intvalue)
      );
      break;
    }
  }
}

