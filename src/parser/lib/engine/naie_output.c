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

#include <stdio.h>

#include "naie_private.h"

/**
 *
 */
NAIG_ERR_T naie_output
  (naie_result_t* result, FILE* output)
{
  unsigned i;
  uint32_t record[ 4 ] = { htonl(result->code), htonl(result->size), 0, 0 };

  if (fwrite(record, sizeof(uint32_t), 4, output) != 4) {
    RETURNERR(NAIG_ERR_WRITE);
  }
  for (i=0; i < result->size; i++) {
    record[ 0 ] = htonl(result->actions[ i ].action);
    record[ 1 ] = htonl(result->actions[ i ].slot);
    record[ 2 ] = htonl(result->actions[ i ].start);
    record[ 3 ] = htonl(result->actions[ i ].length);
    if (fwrite(record, sizeof(uint32_t), 4, output) != 4) {
      RETURNERR(NAIG_ERR_WRITE);
    }
  }
  return NAIG_OK;
}
