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
NAIG_ERR_T naio_slotmap_add
  (
    naio_slotmap_t* slotmap,
    char* name,
    unsigned slot
  )
{
  unsigned i;
  char try[ 64 ];
  char scratch[ 512 ];
  char* str = scratch;
  int potentialdouble = 1;
  unsigned counter = 1;

  for (i=0; i < slotmap->count; i++) {
    if (slotmap->table[ i ].slot == slot) {
      return NAIG_OK;
    }
  }
  if (slotmap->count == slotmap->length) {
    slotmap->length += 8;
    slotmap->table = realloc(
      slotmap->table,
      sizeof(slotmap->table[ 0 ]) * slotmap->length
    );
  }
#ifdef _DEBUG
  fprintf(stderr, "Slotmap add '%s' -> %u\n", name, slot);
#endif
  snprintf(
    slotmap->table[ slotmap->count ].name,
    sizeof(slotmap->table[ slotmap->count ].name),
    "%s",
    name
  );
  slotmap->table[ slotmap->count ].slot = slot;
  ++(slotmap->count);
  return NAIG_OK;
}
