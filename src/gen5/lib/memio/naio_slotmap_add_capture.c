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

#include "naio_private.h"

/**
 *
 */
NAIG_ERR_T naio_slotmap_add_capture
  (
    naio_slotmap_t* slotmap,
    naio_resobj_t* rule,
    naio_resobj_t* capture,
    unsigned slot
  )
{
  unsigned i;
  char try[ 64 ];
  char scratch[ 512 ];
  char* str = scratch;
  int potentialdouble = 1;
  unsigned counter = 1;

  snprintf(
    scratch,
    sizeof(scratch),
    "%s_%s",
    rule->children[ 0 ]->string,
    capture ? capture->string : ""
  );
  for (i=1 + strlen(rule->children[ 0 ]->string); i < strlen(str); i++) {
    if (str[ i ] >= 'a' && str[ i ] <= 'z') {
      str[ i ] = ((str[ i ] - 'a') + 'A');
    } else {
      if (str[ i ] >= 'A' && str[ i ] <= 'Z') {
        continue;
      }
/*
      if (i > 1 && str[ i ] >= '0' && str[ i ] <= '9') {
        continue;
      }
      if (str[ i ] == '_') {
        continue;
      }
*/
      memmove(str + i, str + i + 1, strlen(str) - i);
      --i;
    }
  }
  if (strlen(str) > 32) {
    str[ 32 ] = 0;
  }
  snprintf(try, sizeof(try), "%s", str);
  while (potentialdouble) {
    potentialdouble = 0;
    for (i=0; i < slotmap->count; i++) {
      if (0 == strcmp(slotmap->table[ i ].name, try)) {
        snprintf(try, sizeof(try), "%s_%u", str, counter++);
        potentialdouble = 1;
      }
    }
  }
#ifdef _DEBUG
  fprintf(stderr, "Slotmap add '%s' -> %u\n", try, slot);
#endif
  CHECK(naio_slotmap_add(slotmap, try, slot));
  return NAIG_OK;
}
