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
void naic_debug
  (naic_t* naic)
{
#ifdef _DEBUG
  fprintf(stderr, "Token %u; %s %u->%u '%-.*s'\n"
    , naic->capindex
    , naic_slotmap_string(naic->captures->actions[ naic->capindex ].slot)
    , naic->captures->actions[ naic->capindex ].start
    , naic->captures->actions[ naic->capindex ].length
    , naic->captures->actions[ naic->capindex ].length
    , naic->grammar + naic->captures->actions[ naic->capindex ].start
  );
#else
  (void)naic;
#endif
}
