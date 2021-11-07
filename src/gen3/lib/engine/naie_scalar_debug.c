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
 *
 */
void naie_scalar_debug
  (naie_scalar_t s)
{
  uint32_t type = s.type;

  switch (type) {
  case NAIE_SCALAR_TYPE_VOID:
    fprintf(stderr, "Scalar void\n");
    break;
  case NAIE_SCALAR_TYPE_BOOLEAN:
    fprintf(stderr, "Scalar boolean (%s)\n", s.value._int ? "true" : "false");
    break;
  case NAIE_SCALAR_TYPE_UNSIGNED:
    fprintf(stderr, "Scalar unsigned %u\n", s.value._unsigned);
    break;
  case NAIE_SCALAR_TYPE_INT:
    fprintf(stderr, "Scalar int %d\n", s.value._int);
    break;
  case NAIE_SCALAR_TYPE_FLOAT:
    fprintf(stderr, "Scalar float %f\n", s.value._float);
    break;
  case NAIE_SCALAR_TYPE_STRING:
    fprintf(stderr, "Scalar string %u\n", s.value._unsigned);
    break;
  case NAIE_SCALAR_TYPE_TYPEDLIST:
    fprintf(stderr, "Scalar typedlist\n");
    break;
  case NAIE_SCALAR_TYPE_FREELIST:
    fprintf(stderr, "Scalar freelist\n");
    break;
  case NAIE_SCALAR_TYPE_STRINGMAP:
    fprintf(stderr, "Scalar stringmap\n");
    break;
  case NAIE_SCALAR_TYPE_REFERENCE:
    fprintf(stderr, "Scalar register %u\n", s.value._unsigned);
    break;
  case NAIE_SCALAR_TYPE_STACKRETURN:
    fprintf(stderr, "Scalar stackreturn\n");
    break;
  default:
    fprintf(stderr, "Scalar unknown\n");
  }
}
