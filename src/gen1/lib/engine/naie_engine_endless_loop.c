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

#include "naie_private.h"

/**
 *
 */
NAIG_ERR_T naie_engine_endless_loop
  (naie_engine_t* engine)
{
  unsigned i;

  if (engine->flags & NAIE_FLAG_ENDLESS) {
    for (i=0; i < engine->loopdetect.size; i++) {
fprintf(stderr, "Comparing %u %u %u %u\n", engine->loopdetect.entries[ i ].bytecode_pos, engine->bytecode_pos, engine->loopdetect.entries[ i ].bytecode_pos, engine->input_pos);

      if (engine->loopdetect.entries[ i ].bytecode_pos == engine->bytecode_pos
          && engine->loopdetect.entries[ i ].bytecode_pos == engine->input_pos)
      {
        RETURNERR(NAIE_ERR_ENDLESSLOOP);
      }
    }
    if (engine->loopdetect.size == NAIE_MAX_LOOPDETECT) {
      memmove(
        &(engine->loopdetect.entries[ 1 ]),
        &(engine->loopdetect.entries[ 0 ]),
        (sizeof(engine->loopdetect.entries[ 0 ]) * (NAIE_MAX_LOOPDETECT-1))
      );
    } else {
      if (engine->loopdetect.size) {
        memmove(
          &(engine->loopdetect.entries[ 1 ]),
          &(engine->loopdetect.entries[ 0 ]),
          (sizeof(engine->loopdetect.entries[ 0 ]) * engine->loopdetect.size)
        );
      }
      ++(engine->loopdetect.size);
    }
    engine->loopdetect.entries[ 0 ].bytecode_pos = engine->bytecode_pos;
    engine->loopdetect.entries[ 0 ].input_pos = engine->input_pos;
  }
  return NAIG_OK;
}
