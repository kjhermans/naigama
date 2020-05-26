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
/*
NAIG_ERR_T naic_token_next_sibling
  (naic_t* naic, unsigned* index)
{
  unsigned i = *index, end = naic->captures->actions[ i ].stop;

  for (++i; i < naic->captures->size; i++) {
    if (naic->captures->actions[ i ].start >= end) {
      *index = i;
      return NAIG_OK;
    }
  }
  return NAIC_NOTFOUND;
}
*/
