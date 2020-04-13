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

#include <naigama/compiler/naic.h>

/**
 *
 */
NAIG_ERR_T naic_slotmap_write
  (naic_slotmap_t* slotmap, FILE* out)
{
  unsigned i;

  for (i=0; i < slotmap->size; i++) {
    uint32_t f[2] = { htonl(slotmap->table[ i ].slot), -1 };
    char* str = slotmap->table[ i ].name;
    if (fwrite(f, sizeof(uint32_t), 2, out) != 2) {
      RETURNERR(NAIG_ERR_WRITE);
    }
    if (fwrite(str, 1, strlen(str)+1, out) != strlen(str)+1) {
      RETURNERR(NAIG_ERR_WRITE);
    }
  }
  return NAIG_OK;
}
