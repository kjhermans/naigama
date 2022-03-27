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

#include "../naic_private.h"

static
unsigned naic_set_char
  (char* chr)
{
  switch (*chr) {
  case '\\':
    ++chr;
    switch (*chr) {
    case 'n':
      return (unsigned)'\n';
    case 'r':
      return (unsigned)'\r';
    case 't':
      return (unsigned)'\t';
    case 'v':
      return (unsigned)'\v';
    case '\\':
      return (unsigned)'\\';
    case ']':
      return (unsigned)']';
    case '0': case '1': case '2': case '3': case '4':
    case '5': case '6': case '7': case '8': case '9':
      return octal(chr[0], chr[1], chr[2]);
    }
    __attribute__((fallthrough));
  default:
    return (unsigned)(*chr);
  }
}

/**
 *
 */
NAIG_ERR_T naic_compile_set
  (naic_t* naic, naio_resobj_t* set)
{
  unsigned char bitmask[ 32 ] = { 0 };
  int invert = 0;
  unsigned i;

  if (naio_result_object_query(set, 1, SLOT_SETNOT, 0))
  {
    invert = 1;
  }
  for (i=1; i < set->nchildren; i++) {
    if (set->children[ i ]->type == SLOT_SET_NRTV) {
      unsigned from = naic_set_char(set->children[ i ]->string);
      unsigned until = naic_set_char(set->children[ ++i ]->string);

      /** optimizing single ranges in sets **/
      if (!invert && set->nchildren == 4) {
        NAIC_WRITE("  range %u %u\n", from, until);
        return NAIG_OK;
      }

      for (; from <= until; from++) {
        NAIC_SET_BIT_SET(bitmask, from);
      }
    } else if (set->children[ i ]->type == SLOT_SET_NRTV_2) {
      unsigned chr = naic_set_char(set->children[ i ]->string);
      NAIC_SET_BIT_SET(bitmask, chr);
    }
  }
  if (invert) {
    for (i=0; i < sizeof(bitmask); i++) {
      bitmask[ i ] = ~bitmask[ i ];
    }
  }
  NAIC_WRITE("  set ");
  for (i=0; i < sizeof(bitmask); i++) {
    NAIC_WRITE("%.2x", bitmask[ i ]);
  }
  NAIC_WRITE("\n");
  return NAIG_OK;
}
