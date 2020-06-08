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
 *
 */
NAIG_ERR_T naia_label_put
  (naia_t* naia, char* str, unsigned len, unsigned offset)
{
  unsigned i;

  for (i=0; i < naia->labels.size; i++) {
    if (naia->labels.table[ i ].len == len &&
        0 == memcmp(naia->labels.table[ i ].str, str, len))
    {
      fprintf(stderr, "Double label encountered '%-.*s'\n", len, str);
      RETURNERR(NAIA_ERR_LABEL);
    }
  }
  if (i < NAIA_LABELS_MAX) {
    naia->labels.table[ naia->labels.size ].str = str;
    naia->labels.table[ naia->labels.size ].len = len;
    naia->labels.table[ naia->labels.size ].offset = offset;
  }
  ++(naia->labels.size);
#ifdef _DEBUG
  fprintf(stderr, "Label %-.*s at offset %u\n", len, str, offset);
#endif
  return NAIG_OK;
}
