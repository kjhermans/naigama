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

#define REGISTER_INCREASE 32

/**
 *
 */
NAIG_ERR_T naie_register_store
  (naie_engine_t* engine, uint32_t reg, uint32_t value)
{
  unsigned i;

  for (i=0; i < engine->reg.length; i++) {
    if (engine->reg.entries[ i ].value == 0 ||
          (engine->reg.entries[ i ].reg == reg &&
           engine->reg.entries[ i ].stacklen == engine->stack.count))
    {
      engine->reg.entries[ i ].reg = reg;
      engine->reg.entries[ i ].stacklen = engine->stack.count;
      engine->reg.entries[ i ].value = value;
      return NAIG_OK;
    }
  }
  if (engine->reg.realloc) {
    engine->reg.entries = realloc(
      engine->reg.entries,
      sizeof(naie_register_t) * (engine->reg.length + REGISTER_INCREASE)
    );
    if (NULL != engine->reg.entries) {
      memset(
        &(engine->reg.entries[ engine->reg.length ]),
        0,
        (engine->reg.length + REGISTER_INCREASE)
      );
      engine->reg.length += REGISTER_INCREASE;
      return naie_register_store(engine, reg, value);
    }
  }
  return NAIE_ERR_REGFULL;
}
