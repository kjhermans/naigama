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

#include <naigama/compiler/naic.h>

/**
 * Finds the first child token (ie position-wise completely encompassed
 * by the parent) of a token given its index.
 */
NAIG_ERR_T naic_token_first_child
  (naic_t* naic, unsigned* index)
{
  unsigned i = *index
         , begin = naic->captures->actions[ i ].start
         , end = naic->captures->actions[ i ].stop;

  for (++i; i < naic->captures->size; i++) {
    if (naic->captures->actions[ i ].start >= begin
        && naic->captures->actions[ i ].stop <= end)
    {
      *index = i;
      return NAIG_OK;
    }
  }
  return NAIC_NOTFOUND;
}
