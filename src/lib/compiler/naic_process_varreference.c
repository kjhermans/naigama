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
NAIG_ERR_T naic_process_varreference
  (naic_t* naic)
{
  naie_resact_t* a = &(naic->captures->actions[ naic->capindex ]);
  char* chr;
  unsigned slot;

#ifdef _DEBUG
  fprintf(stderr, "-- %s ", __FILE__); naic_debug(naic);
#endif

  ++a;
  chr = naic->grammar + a->start;
  if (a->slot == SLOT_VARREFERENCE_IDENT) {
    CHECK(naic_var_get(naic, chr, a->stop - a->start, &slot));
  } else {
    slot = atoi_substr(naic->grammar, a->start, a->stop - a->start);
  }
  CHECK(naic->write(naic->write_arg, "  var %u\n"
                         , slot
  ));
  return NAIG_OK;
}
