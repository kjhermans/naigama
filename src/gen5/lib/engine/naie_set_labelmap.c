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

#include <unistd.h>
#include <fcntl.h>

#include "naie_private.h"

/**
 * Loads the labelmap into the engine.
 */
NAIG_ERR_T naie_set_labelmap
  (
    naie_engine_t* engine,
    const char* filename
  )
{
  unsigned char block[ 1024 ];
  unsigned blocksize = 0;
  int fd = open(filename, O_RDONLY, 0);

  if (fd == -1) {
    RETURNERR(NAIG_ERR_LABELMAP);
  }
  while (1) {
    int r = 0;
    unsigned l = sizeof(block) - blocksize;
    if (l && (r = read(fd, &(block[ blocksize ]), l)) < 0) {
      RETURNERR(NAIG_ERR_LABELMAP);
    }
    if (r == 0 && blocksize == 0) {
      break;
    }
    blocksize += r;
    while (blocksize) {
      unsigned i;
OneMoreLabel:
      if (blocksize > 5) {
        uint32_t offset;
        char* string = (char*)(&(block[ 4 ]));
        memcpy(&offset, block, 4);
        offset = SET_32BIT_VALUE(offset);
        offset &= ~(0xff << 24);
        for (i=4; i < blocksize; i++) {
          if (block[ i ] == 0) {
            CHECK(naie_engine_add_label(engine, string, offset));
            memmove(&(block[ 0 ]), &(block[ i + 1 ]), blocksize - (i + 1));
            blocksize -= (i+1);
            goto OneMoreLabel;
          }
        }
        goto OneMoreRead;
      } else {
        goto OneMoreRead;
      }
    }
OneMoreRead: ;
  }
  return NAIG_OK;
}
