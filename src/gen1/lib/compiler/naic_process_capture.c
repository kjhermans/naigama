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
NAIG_ERR_T naic_process_capture
  (naic_t* naic)
{
  unsigned slot = (naic->slot)++;
  naie_resact_t* a = &(naic->captures->actions[ naic->capindex ]);

#ifdef _DEBUG
  fprintf(stderr, "-- %s ", __FILE__); naic_debug(naic);
#endif

  if (naic->slotmap) {
    CHECK(
      naic_slotmap_add(
        naic->slotmap,
        naic->grammar,
        naic->currentrule,
        a,
        slot
      )
    );
  }
  CHECK(naic->write(naic->write_arg, "  opencapture %u\n", slot));
  ++(naic->capindex);
  CHECK(naic_process_expression(naic));
  CHECK(naic->write(naic->write_arg, "  closecapture %u 0\n", slot));
  if (naic->captures->actions[ naic->capindex + 1 ].slot
      == SLOT_REPLACE_REPLACETERMS)
  {
    ++(naic->capindex);
    CHECK(naic_process_replaceterms(naic, slot));
  }
  return NAIG_OK;
}
