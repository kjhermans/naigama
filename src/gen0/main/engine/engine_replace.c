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
      names of its contributors may be used to endnaie or promote products
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

#include <stdlib.h>
#include <string.h>

#include <naigama/engine/naie.h>
#include <naigama/naig_private.h>

struct engine_repl
{
  unsigned char* copy;
  unsigned size;
};

static
NAIG_ERR_T engine_repl_delete
  (const unsigned char* orig, unsigned start, unsigned length, void* arg)
{
  struct engine_repl* e = (struct engine_repl*)arg;
  (void)orig;

  memmove(
    e->copy + start,
    e->copy + start + length,
    e->size - (start + length)
  );
  e->size -= length;
  return NAIG_OK;
}

static
NAIG_ERR_T engine_repl_insert
  (const unsigned char* orig, unsigned typ, unsigned start, uint32_t chr, void* arg)
{
  struct engine_repl* e = (struct engine_repl*)arg;
  (void)orig;

  e->copy = (unsigned char*)realloc(e->copy, e->size + 4);
  switch (typ) {
  case NAIG_ACTION_REPLACE_CHAR:
    memmove(
      e->copy + start + 1,
      e->copy + start,
      e->size - start
    );
    e->copy[ start ] = (unsigned char)chr;
    e->size += 1;
    break;
  case NAIG_ACTION_REPLACE_QUAD:
    memmove(
      e->copy + start + 4,
      e->copy + start,
      e->size - start
    );
    memcpy(e->copy + start, &chr, 4);
    e->size += 4;
    break;
  }
  return NAIG_OK;
}

/**
 *
 */
NAIG_ERR_T engine_replace
  (naie_engine_t* engine, naie_result_t* result, FILE* output)
{
  struct engine_repl e = {
    malloc(engine->input_length),
    engine->input_length
  };

  memcpy(e.copy, engine->input, engine->input_length);
  CHECK(
    naie_result_handle(
      engine,
      result,
      NULL,
      engine_repl_delete,
      engine_repl_insert,
      &e
    )
  );
  fprintf(output, "%-.*s", e.size, e.copy);
  free(e.copy);
  return NAIG_OK;
}
