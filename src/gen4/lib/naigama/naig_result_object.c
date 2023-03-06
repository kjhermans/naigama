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

#include <naigama/parser/naip.h>

#include "naig_private.h"

static
naig_resobj_t* naig_result_object_children
  (
    const unsigned char* input,
    unsigned inputlength,
    naip_actionlist_t* result,
    naig_resobj_t* object,
    unsigned i
  );

static
naig_resobj_t* naig_result_object_
  (
    const unsigned char* input,
    unsigned inputlength,
    naip_actionlist_t* result,
    unsigned i
  )
{
  naig_resobj_t* object = malloc(sizeof(naig_resobj_t));
  naip_action_t action;

  naip_actionlist_get(result, i, &action);
  memset(object, 0, sizeof(*object));
  object->type = action.slot;
  object->origoffset = action.input_offset;
  object->stringlen = action.length;
  object->string = malloc(object->stringlen + 1);
  memcpy(object->string, input + object->origoffset, object->stringlen);
  object->string[ object->stringlen ] = 0;
  object->children = 0;
  object->nchildren = 0;
  return naig_result_object_children(input, inputlength, result, object, i+1);
}

static
naig_resobj_t* naig_result_object_children
  (
    const unsigned char* input,
    unsigned inputlength,
    naip_actionlist_t* result,
    naig_resobj_t* parent,
    unsigned i
  )
{
  naip_action_t action;

  for (; i < result->count; i++) {
    naip_actionlist_get(result, i, &action);
    if (action.input_offset >= parent->origoffset + parent->stringlen) {
      break;
    }
/*
    if (action.type != NAIG_ACTION_OPENCAPTURE) {
      continue;
    }
*/
    if (parent->nchildren
        && action.input_offset
           < parent->children[ parent->nchildren-1 ]->origoffset
             + parent->children[ parent->nchildren-1 ]->stringlen)
    {
      continue;
    }
    parent->children = realloc(
      parent->children,
      sizeof(naig_resobj_t*) * (parent->nchildren + 1)
    );
    parent->children[ parent->nchildren ]
      = naig_result_object_(input, inputlength, result, i);
    parent->children[ parent->nchildren ]->parent = parent;
    ++(parent->nchildren);
  }
  return parent;
}

/**
 * Returns a malloc-ed object containing the capture tree.
 */
naig_resobj_t* naig_result_object
  (
    const unsigned char* input,
    unsigned inputlength,
    naip_actionlist_t* result
  )
{
  naig_resobj_t* object = malloc(sizeof(naig_resobj_t));

  memset(object, 0, sizeof(*object));
  object->type = -1; // top
  object->origoffset = 0;
  object->stringlen = inputlength;
  object->string = malloc(object->stringlen + 1);
  memcpy(object->string, input + object->origoffset, object->stringlen);
  object->string[ object->stringlen ] = 0;
  object->parent = 0;
  object->children = 0;
  object->nchildren = 0;
  
  return naig_result_object_children(input, inputlength, result, object, 0);
}
