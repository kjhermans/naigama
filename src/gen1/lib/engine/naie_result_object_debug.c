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

#include <ctype.h>

#include "naie_private.h"

void naie_result_object_debug_
  (naie_resobj_t* object, unsigned indent)
{
  unsigned i;

  if (object->type == -1) {
    fprintf(stderr, "TOP  - ");
  } else {
    fprintf(stderr, "%.4u ", object->type);
  }
  for (i=0; i < indent; i++) { fprintf(stderr, "--"); }
  fprintf(stderr, "| ");
  for (i=0; i < object->stringlen; i++) {
    if (!isprint(object->string[ i ])) {
      fprintf(stderr, ".");
    } else {
      fprintf(stderr, "%c", object->string[ i ]);
    }
  }
  fprintf(stderr, "\n");
  for (i=0; i < object->nchildren; i++) {
    naie_result_object_debug_(object->children[ i ], indent + 1);
  }
}

/**
 *
 */
void naie_result_object_debug
  (naie_resobj_t* object)
{
  naie_result_object_debug_(object, 0);
}
