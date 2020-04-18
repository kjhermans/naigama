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
  fprintf(naic->output, "  opencapture %u\n", slot);
  ++(naic->capindex);
  CHECK(naic_process_expression(naic));
  fprintf(naic->output, "  closecapture %u 0\n", slot);
  if (naic->captures->actions[ naic->capindex + 1 ].slot
      == SLOT_REPLACE_REPLACETERMS)
  {
    ++(naic->capindex);
    CHECK(naic_process_replaceterms(naic));
  }
  return NAIG_OK;
}
