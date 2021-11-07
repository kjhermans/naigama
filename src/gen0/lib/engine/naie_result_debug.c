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

#include "naie_private.h"

/**
 * Prints to stderr the engine result (action list).
 */
void naie_result_debug
  (naie_result_t* result, unsigned char* data)
{
  unsigned i, j;

  fprintf(stderr, "End code: %d\n", result->code);
  fprintf(stderr, "%u actions total\n", result->count);
  for (i=0; i < result->count; i++) {
    switch (result->actions[ i ].action) {
    case NAIG_ACTION_OPENCAPTURE:
      fprintf(stderr, "Action #%u: capture slot %u, %u->%u \""
        , i
        , result->actions[ i ].slot
        , result->actions[ i ].start
        , result->actions[ i ].length
      );
      for (j = 0; j < result->actions[ i ].length; j++) {
        unsigned char c = data[ result->actions[ i ].start + j ];
        if (c == '\\' || c == '\"') {
          fprintf(stderr, "\\%c", c);
        } else if (isspace(c) || isprint(c)) {
          fprintf(stderr, "%c", c);
        } else {
          fprintf(stderr, "\\x%.2x", c);
        }
      }
      fprintf(stderr, "\"\n");
      break;
    case NAIG_ACTION_CLOSECAPTURE:
      break;
    case NAIG_ACTION_DELETE:
      fprintf(stderr, "Action #%u: delete slot %u, %u->%u\n"
        , i
        , result->actions[ i ].slot
        , result->actions[ i ].start
        , result->actions[ i ].length
      );
      break;
    case NAIG_ACTION_REPLACE_CHAR:
      fprintf(stderr, "Action #%u: insert slot %u, at %u char %.2x\n"
        , i
        , result->actions[ i ].slot
        , result->actions[ i ].start
        , result->actions[ i ].length
      );
      break;
    case NAIG_ACTION_REPLACE_QUAD:
      fprintf(stderr, "Action #%u: insert slot %u, at %u quad %.8x\n"
        , i
        , result->actions[ i ].slot
        , result->actions[ i ].start
        , result->actions[ i ].length
      );
      break;
    }
  }
}

