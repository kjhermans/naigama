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

#include "naia_private.h"

/**
 *
 */
NAIG_ERR_T naia_label_put
  (naia_t* naia, char* str, unsigned len, unsigned offset)
{
  unsigned i;

  for (i=0; i < naia->labels.count; i++) {
    if (naia->labels.entries[ i ].len == len &&
        0 == memcmp(naia->labels.entries[ i ].str, str, len))
    {
      fprintf(stderr, "Double label encountered '%-.*s'\n", len, str);
      RETURNERR(NAIA_ERR_LABEL);
    }
  }
  if (naia->labels.count >= naia->labels.length) {
    naia->labels.length = naia->labels.count + 32;
    naia->labels.entries = realloc(
      naia->labels.entries, sizeof(naia_labent_t) * naia->labels.length
    );
  }
  naia->labels.entries[ naia->labels.count ].str = str;
  naia->labels.entries[ naia->labels.count ].len = len;
  naia->labels.entries[ naia->labels.count ].offset = offset;
  ++(naia->labels.count);
#ifdef _DEBUG
  fprintf(stderr, "Label %-.*s at offset %u\n", len, str, offset);
#endif
  return NAIG_OK;
}
