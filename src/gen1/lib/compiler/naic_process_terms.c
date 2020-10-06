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
  while (naic->capindex < naic->captures->count
         && naic->captures->actions[ naic->capindex ].start < end)
  {
    if (naic->captures->actions[ naic->capindex ].slot == SLOT_TERMS_TERM) {
      ++(naic->capindex);
      if (naic->captures->actions[ naic->capindex ].slot
          == SLOT_TERM_ENDOWEDMATCHER)
      {
        if (naic->flags & (NAIC_FLG_TERSE|NAIC_FLG_LOOPS)) {
          CHECK(naic_process_endowedmatcher_noloops(naic));
        } else {
          CHECK(naic_process_endowedmatcher(naic));
        }
      }
    } else {
      snprintf(naic->error, sizeof(naic->error),
        "Unexpected term token %u",
        naic->captures->actions[ naic->capindex ].slot
      );
      RETURNERR(NAIC_ERR_TOKEN);
    }
  }
  return NAIG_OK;
}
