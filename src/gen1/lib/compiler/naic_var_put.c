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
NAIG_ERR_T naic_var_put
  (naic_t* naic, char* str, unsigned len, unsigned slot)
{
  unsigned i;

  if (naic->rulevarmap.size >= NAIC_RULEVARMAP_SIZE) {
    RETURNERR(NAIC_ERR_VARMAPFULL);
  }
  for (i=0; i < naic->rulevarmap.size; i++) {
    if (naic->rulevarmap.table[ i ].keysize == len
        && 0 == memcmp(naic->rulevarmap.table[ i ].key, str, len))
    {
      if (naic->rulevarmap.table[ i ].slot == slot) {
        return NAIG_OK; // same definition revisited through a quantifier
      } else {
        RETURNERR(NAIC_ERR_VARDOUBLE); // namespace collision
      }
    }
  }
  naic->rulevarmap.table[ i ].key = str;
  naic->rulevarmap.table[ i ].keysize = len;
  naic->rulevarmap.table[ i ].slot = slot;
  ++(naic->rulevarmap.size);
  return NAIG_OK;
}
