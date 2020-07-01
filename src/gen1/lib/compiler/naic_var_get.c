/**
 * This file is part of Raksaka / NAIG,
 * which is a network guard / message parser solution.
 * Copyright 2020, KJ Hermans
 * Written by KJ Hermans <kees.jan.hermans@gmail.com>
 *
 * LICENSE:
 * Withheld
 *
 * \file
 * \brief
 */

#include "naic_private.h"

/**
 *
 */
NAIG_ERR_T naic_var_get
  (naic_t* naic, char* str, unsigned len, unsigned* slot)
{
  unsigned i;

  for (i=0; i < naic->rulevarmap.size; i++) {
    if (naic->rulevarmap.table[ i ].keysize == len
        && 0 == memcmp(naic->rulevarmap.table[ i ].key, str, len))
    {
      *slot = naic->rulevarmap.table[ i ].slot;
      return NAIG_OK;
    }
  }
  return NAIC_NOTFOUND;
}
