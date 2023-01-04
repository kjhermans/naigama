/**
 * This file is part of Oroszlan, a parsing and scripting environment

Copyright (c) 2022, Kees-Jan Hermans <kees.jan.hermans@gmail.com>
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the organization nor the
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
 * Transform the engine's actions list into the result object tree structure.
 */
naio_resobj_t* naie_resobj_new
  (naie_engine_t* engine)
{
  naio_resobj_t* result = calloc(1, sizeof(naio_resobj_t));
  naio_resobj_t* parent = result;
  naio_resobj_t* child;
  naie_action_t* a;
  unsigned i=0;

  for (; i < engine->actions.count; i++) {
    a = &(engine->actions.entries[ i ]);
    switch (a->action) {

    case NAIG_ACTION_OPENCAPTURE:
      child = calloc(1, sizeof(naio_resobj_t));
      child->type = a->slot;
      child->origoffset = a->inputpos;
/*
      if ((child->origoffset = a->inputpos) >= engine->input_length) {
        return NULL; // error; offset doesn't match input
      }
*/
      child->parent = parent;
      parent->children = (naio_resobj_t**)realloc(
        parent->children,
        sizeof(naio_resobj_t*) * (parent->nchildren + 1)
      );
      parent->children[ (parent->nchildren)++ ] = child;
      parent = child;
      break;

    case NAIG_ACTION_CLOSECAPTURE:
      child = parent;
      if (parent->parent == NULL) {
        return NULL; /* error; too many close captures */
      }
      parent = parent->parent;
      if (a->inputpos < child->origoffset) {
        return NULL; /* error; end is before beginning of capture region */
      }
      if (child->origoffset + child->stringlen > engine->input_length) {
        return NULL; /* error; cannot copy beyond end of input */
      }
      child->stringlen = a->inputpos - child->origoffset;
      child->string = malloc(child->stringlen + 1);
      if (child->stringlen) {
        memcpy(
          child->string,
          engine->input + child->origoffset,
          child->stringlen
        );
      }
      child->string[ child->stringlen ] = 0;
      break;
     
    }
  }
  if (parent != result) {
    return NULL; /* error; too few close captures */
  }

  return result;
}
