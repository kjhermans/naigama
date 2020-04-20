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

#include <naigama/engine/naie.h>

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
    int r;
    unsigned l = sizeof(block) - blocksize;
    if ((r = read(fd, &(block[ blocksize ]), l)) < 0) {
      RETURNERR(NAIE_ERR_LABELMAP);
    }
    if (r == 0 && blocksize == 0) {
      break;
    }
    blocksize += r;
    while (blocksize) {
      unsigned i;
OneMoreLabel:
      for (i=0; i < blocksize; i++) {
        if (block[ i ] == 0) {
          if (i < blocksize - 4) {
            char* string = (char*)(&(block[ 0 ]));
            uint32_t offset;
            memcpy(&offset, &(block[ i ]), 4);
            offset = htonl(offset);
            CHECK(naie_engine_add_label(engine, string, offset));
            memmove(&(block[ 0 ]), &(block[ i + 4 ]), blocksize - (i + 4));
            blocksize -= (i + 4);
            goto OneMoreLabel;
          }
          goto OneMoreRead;
        }
      }
      goto OneMoreRead;
    }
OneMoreRead: ;
  }
  return NAIG_OK;
}
