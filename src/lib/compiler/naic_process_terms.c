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
NAIG_ERR_T naic_process_terms
  (naic_t* naic)
{
  unsigned end = naic->captures->actions[ naic->capindex ].start +
                 naic->captures->actions[ naic->capindex ].length;

#ifdef _DEBUG
  fprintf(stderr, "-- %s ", __FILE__); naic_debug(naic);
#endif

  ++(naic->capindex);
  while (naic->capindex < naic->captures->size
         && naic->captures->actions[ naic->capindex ].start < end)
  {
    if (naic->captures->actions[ naic->capindex ].slot == SLOT_TERMS_TERM) {
      CHECK(naic_process_term(naic));
    } else {
      RETURNERR(NAIC_ERR_TOKEN);
    }
  }
  return NAIG_OK;
}
