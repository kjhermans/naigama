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
NAIG_ERR_T naic_process_reference
  (naic_t* naic)
{
#ifdef _DEBUG
  fprintf(stderr, "-- %s ", __FILE__); naic_debug(naic);
#endif

  fprintf(naic->output, "  call %-.*s\n"
    , (int)(naic->captures->actions[ naic->capindex ].stop -
            naic->captures->actions[ naic->capindex ].start)
    , naic->grammar +
        naic->captures->actions[ naic->capindex ].start
  );
  ++(naic->capindex);
  return NAIG_OK;
}
