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

#include "naia_private.h"

/**
 * Topmost function
 */
NAIG_ERR_T naia_label_map_write
  (naia_t* naia, FILE* map)
{
  unsigned i;

  for (i=0; i < naia->labels.count; i++) {
    uint8_t close = 0;
    uint32_t offset = SET_32BIT_VALUE(naia->labels.entries[ i ].offset);
    size_t s;
    s = fwrite(&offset, 4, 1, map);
    if (s != 1) {
      RETURNERR(NAIG_ERR_WRITE);
    }
    s = fwrite(
      naia->labels.entries[ i ].str,
      1,
      naia->labels.entries[ i ].len,
      map
    );
    if (s != naia->labels.entries[ i ].len) {
      RETURNERR(NAIG_ERR_WRITE);
    }
    s = fwrite(&close, 1, 1, map);
    if (s != 1) {
      RETURNERR(NAIG_ERR_WRITE);
    }
  }
  return NAIG_OK;
}
