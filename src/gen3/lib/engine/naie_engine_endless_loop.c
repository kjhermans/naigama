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
 * Endless loop detection is based on the premise that if
 * we hit the same input position on the same bytecode offset
 * we're inside an endless loop.
 *
 * DON'T USE; IS NOT A VALID ALGORITHM
 */
NAIG_ERR_T naie_engine_endless_loop
  (naie_engine_t* engine)
{
/*
  if (engine->flags & NAIE_FLAG_ENDLESS) {
    if (engine->loopdetect.length != engine->input_length) {
      engine->loopdetect.length = engine->input_length;
      engine->loopdetect.count = engine->loopdetect.length;
      engine->loopdetect.entries = realloc(engine->loopdetect.entries, sizeof(naie_loopdetectentry_t) * engine->loopdetect.length);
      memset(engine->loopdetect.entries, 0xff, sizeof(naie_loopdetectentry_t) * engine->loopdetect.length);
    }
fprintf(stderr, "Checking endless loop %u,%u -> %u,%u\n", engine->input_pos, engine->bytecode_pos, engine->input_pos, engine->loopdetect.entries[ engine->input_pos ].bytecode_pos);
    if (engine->loopdetect.entries[ engine->input_pos ].bytecode_pos == engine->bytecode_pos) {
      RETURNERR(NAIG_ERR_ENDLESSLOOP);
    }
    engine->loopdetect.entries[ engine->input_pos ].bytecode_pos = engine->bytecode_pos;
  }
*/
  return NAIG_OK;
}
