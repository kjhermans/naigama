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

static inline
NAIG_ERR_T naie_scalar_lt_ii
  (int i1, int i2, int* ir)
{
  (*ir) = i1 < i2;
  return NAIG_OK;
}

static inline
NAIG_ERR_T naie_scalar_lt_uu
  (unsigned i1, unsigned i2, int* ir)
{
  (*ir) = i1 < i2;
  return NAIG_OK;
}

/**
 *
 */
NAIG_ERR_T naie_scalar_lt
  (naie_scalar_t s1, naie_scalar_t s2, naie_scalar_t* result)
{
  uint32_t t1 = s1.type, t2 = s2.type;

  if (t1 == NAIE_SCALAR_TYPE_VOID) {
    t1 = NAIE_SCALAR_TYPE_INT;
    s1.value._int = 0;
  }
  if (t2 == NAIE_SCALAR_TYPE_VOID) {
    t2 = NAIE_SCALAR_TYPE_INT;
    s2.value._int = 0;
  }
  switch (t1) {
  case NAIE_SCALAR_TYPE_BOOLEAN:
  case NAIE_SCALAR_TYPE_UNSIGNED:
    switch (t2) {
    case NAIE_SCALAR_TYPE_BOOLEAN:
    case NAIE_SCALAR_TYPE_UNSIGNED:
      result->type = NAIE_SCALAR_TYPE_BOOLEAN;
      CHECK(
        naie_scalar_lt_uu(
          s1.value._unsigned,
          s2.value._unsigned,
          &(result->value._int)
        )
      );
      return NAIG_OK;
    case NAIE_SCALAR_TYPE_INT:
      result->type = NAIE_SCALAR_TYPE_BOOLEAN;
      CHECK(
        naie_scalar_lt_uu(
          s2.value._unsigned,
          (unsigned)(s1.value._int),
          &(result->value._int)
        )
      );
      return NAIG_OK;
    case NAIE_SCALAR_TYPE_FLOAT:
    case NAIE_SCALAR_TYPE_STRING:
      TODO("Implement");
      return NAIG_OK;
    default:
      return NAIG_ERR_OPERANDTYPE;
    }
  case NAIE_SCALAR_TYPE_INT:
    switch (t2) {
    case NAIE_SCALAR_TYPE_BOOLEAN:
    case NAIE_SCALAR_TYPE_UNSIGNED:
      result->type = NAIE_SCALAR_TYPE_BOOLEAN;
      CHECK(
        naie_scalar_lt_uu(
          (unsigned)(s1.value._int),
          s2.value._unsigned,
          &(result->value._int)
        )
      );
      return NAIG_OK;
    case NAIE_SCALAR_TYPE_INT:
      result->type = NAIE_SCALAR_TYPE_BOOLEAN;
      CHECK(
        naie_scalar_lt_ii(
          s1.value._int,
          s2.value._int,
          &(result->value._int)
        )
      );
      return NAIG_OK;
    case NAIE_SCALAR_TYPE_FLOAT:
    case NAIE_SCALAR_TYPE_STRING:
      break;
    }
    break;
  case NAIE_SCALAR_TYPE_FLOAT:
    break;
  case NAIE_SCALAR_TYPE_STRING:
    break;
  }
  return NAIG_ERR_OPERANDTYPE;
}
