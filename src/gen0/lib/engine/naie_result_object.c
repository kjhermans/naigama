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

static
naie_resobj_t* naie_result_object_children
  (
    naie_engine_t* engine,
    naie_result_t* result,
    naie_resobj_t* object,
    unsigned i
  );

static
naie_resobj_t* naie_result_object_
  (
    naie_engine_t* engine,
    naie_result_t* result,
    unsigned i
  )
{
  naie_resobj_t* object = malloc(sizeof(naie_resobj_t));

  memset(object, 0, sizeof(*object));
  object->type = result->actions[ i ].slot;
  object->origoffset = result->actions[ i ].start;
  object->stringlen = result->actions[ i ].length;
  object->string = malloc(object->stringlen + 1);
  memcpy(object->string, engine->input + object->origoffset, object->stringlen);
  object->string[ object->stringlen ] = 0;
  object->children = 0;
  object->nchildren = 0;
  return naie_result_object_children(engine, result, object, i+1);
}

static
naie_resobj_t* naie_result_object_children
  (
    naie_engine_t* engine,
    naie_result_t* result,
    naie_resobj_t* object,
    unsigned i
  )
{
  for (; i < result->count; i++) {
    if (result->actions[ i ].start >= object->origoffset + object->stringlen) {
      break;
    }
    if (result->actions[ i ].action != NAIG_ACTION_OPENCAPTURE) {
      continue;
    }
    if (object->nchildren
        && result->actions[ i ].start
           < object->children[ object->nchildren-1 ]->origoffset
             + object->children[ object->nchildren-1 ]->stringlen)
    {
      continue;
    }
    object->children = realloc(
      object->children,
      sizeof(naie_resobj_t) * (object->nchildren + 1)
    );
    object->children[ object->nchildren ]
      = naie_result_object_(engine, result, i);
    ++(object->nchildren);
  }
  return object;
}

/**
 * Returns a malloc-ed object containing the capture tree.
 */
naie_resobj_t* naie_result_object
  (
    naie_engine_t* engine,
    naie_result_t* result
  )
{
  naie_resobj_t* object = malloc(sizeof(naie_resobj_t));

  memset(object, 0, sizeof(*object));
  object->type = -1; // top
  object->origoffset = 0;
  object->stringlen = engine->input_length;
  object->string = malloc(object->stringlen + 1);
  memcpy(object->string, engine->input + object->origoffset, object->stringlen);
  object->string[ object->stringlen ] = 0;
  object->children = 0;
  object->nchildren = 0;
  
  return naie_result_object_children(engine, result, object, 0);
}
