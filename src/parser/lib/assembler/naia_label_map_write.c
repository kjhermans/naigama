/**
 * This file is part of Naigama, a parser engine.
 * Copyright 2020, KJ Hermans
 * Written by KJ Hermans <kees.jan.hermans@gmail.com>
 *
 * LICENSE:
 * Withheld
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

  for (i=0; i < naia->labels.size; i++) {
    uint8_t close = 0;
    uint32_t offset = htonl(naia->labels.table[ i ].offset);
    size_t s;
    s = fwrite(&offset, 4, 1, map);
    if (s != 1) {
      RETURNERR(NAIG_ERR_WRITE);
    }
    s = fwrite(
      naia->labels.table[ i ].str,
      1,
      naia->labels.table[ i ].len,
      map
    );
    if (s != naia->labels.table[ i ].len) {
      RETURNERR(NAIG_ERR_WRITE);
    }
    s = fwrite(&close, 1, 1, map);
    if (s != 1) {
      RETURNERR(NAIG_ERR_WRITE);
    }
  }
  return NAIG_OK;
}
