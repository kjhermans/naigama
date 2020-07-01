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
NAIG_ERR_T naia_label_get
  (naia_t* naia, char* str, unsigned len, unsigned* offset)
{
  unsigned i;

  for (i=0; i < naia->labels.size; i++) {
    if (naia->labels.table[ i ].len == len &&
        0 == memcmp(naia->labels.table[ i ].str, str, len))
    {
      *offset = naia->labels.table[ i ].offset;
      return NAIG_OK;
    }
  }
#ifdef _DEBUG
  fprintf(stderr, "Label '%-.*s' not found\n", len, str);
#endif
  RETURNERR(NAIA_ERR_LABEL);
}
