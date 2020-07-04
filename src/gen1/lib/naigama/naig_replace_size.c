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

#include "naig_private.h"

static
NAIG_ERR_T nrsdel
  (const unsigned char* input, unsigned start, unsigned len, void* arg)
{
  int* delta = (int*)arg;
  (void)input;
  (void)start;

  (*delta) += len;
  return NAIG_OK;
}

static
NAIG_ERR_T nrsins
  (const unsigned char* input, unsigned typ, unsigned start, uint32_t c, void* arg)
{
  int* delta = (int*)arg;
  (void)input;
  (void)start;
  (void)c;

  if (typ == NAIG_ACTION_REPLACE_CHAR) {
    (*delta) += 1;
  } else if (typ == NAIG_ACTION_REPLACE_QUAD) {
    (*delta) += 4;
  }
  return NAIG_OK;
}

/**
 * Returns the delta size of the buffer needed to process replacements.
 */
int naig_replace_size
  (naig_result_t* result)
{
  int delta = 0;
  NAIG_ERR_T e;

  e = naie_result_handle(0, &(result->result), 0, nrsdel, nrsins, &delta);
  if (e.code) {
    return 0;
  } else {
    return delta;
  }
}
