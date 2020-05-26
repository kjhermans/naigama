/**
 * This file is part of NAIG.
 * Copyright 2019, KJ Hermans
 * Written by KJ Hermans <kees.jan.hermans@gmail.com>
 *
 * LICENSE:
 * Withheld
 *
 * \file
 * \brief
 */

#include <unistd.h>
#include <fcntl.h>

#include "naie_private.h"

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
    RETURNERR(NAIE_ERR_LABELMAP);
  }
  while (1) {
    int r = 0;
    unsigned l = sizeof(block) - blocksize;
    if (l && (r = read(fd, &(block[ blocksize ]), l)) < 0) {
      RETURNERR(NAIE_ERR_LABELMAP);
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
        offset = htonl(offset);
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
