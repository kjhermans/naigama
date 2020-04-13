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
NAIG_ERR_T naic_process_varcapture
  (naic_t* naic)
{
  unsigned slot = (naic->slot)++;
  naie_resact_t* a = &(naic->captures->actions[ naic->capindex ]);
  char* chr;

#ifdef _DEBUG
  fprintf(stderr, "-- %s ", __FILE__); naic_debug(naic);
#endif

  ++a;
  chr = naic->grammar + a->start;
  CHECK(naic_var_put(naic, chr, a->stop - a->start, slot));
  ++a; /** skip the type for now **/
  //..

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
  naic->capindex += 2;
  CHECK(naic_process_expression(naic));
  fprintf(naic->output, "  closecapture %u 0\n", slot);
  return NAIG_OK;
}
