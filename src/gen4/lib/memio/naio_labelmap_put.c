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
NAIG_ERR_T naio_labelmap_put
  (naio_labelmap_t* map, char* str, unsigned len, unsigned offset)
{
  unsigned i;

  for (i=0; i < map->count; i++) {
    if (map->entries[ i ].len == len &&
        0 == memcmp(map->entries[ i ].str, str, len))
    {
      fprintf(stderr, "Double label encountered '%-.*s'\n", len, str);
      RETURNERR(NAIG_ERR_LABEL);
    }
  }
  if (map->count >= map->length) {
    map->length = map->count + 32;
    map->entries = realloc(
      map->entries, sizeof(naio_labent_t) * map->length
    );
  }
  map->entries[ map->count ].str = str;
  map->entries[ map->count ].len = len;
  map->entries[ map->count ].offset = offset;
  ++(map->count);
#ifdef _DEBUG
  fprintf(stderr, "Label %-.*s at offset %u\n", len, str, offset);
#endif
  return NAIG_OK;
}
