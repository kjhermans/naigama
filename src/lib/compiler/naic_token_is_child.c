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
/*
int naic_token_is_child
  (naic_t* naic, unsigned index)
{
  unsigned begin = naic->captures->actions[ index ].start
         , end = naic->captures->actions[ index ].stop;

  if (naic->captures->actions[ index ].start >= begin
      && naic->captures->actions[ index ].stop <= end)
  {
    return 1;
  }
  return 0;
}
*/
