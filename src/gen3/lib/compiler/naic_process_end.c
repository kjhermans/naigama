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
 * Processes the hardcorded macroes %s %w %a %n %nl, which stand for
 * whitespace, alphabetic ('word'), alphanumeric, numeric and newline
 * character sets, and compiles them to 'set' instructions.
 */
NAIG_ERR_T naic_process_end
  (naic_t* naic)
{
  naie_resact_t* a = &(naic->captures->actions[ naic->capindex ]);
  char* chr = naic->grammar + a->start + 1;

fprintf(stderr, "END '%-.*s'\n", a->length, chr);

#ifdef _DEBUG
  fprintf(stderr, "-- %s ", __FILE__); naic_debug(naic);
#endif

  return NAIG_OK;
}
