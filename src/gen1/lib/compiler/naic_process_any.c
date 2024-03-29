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
NAIG_ERR_T naic_process_any
  (naic_t* naic)
{
#ifdef _DEBUG
  fprintf(stderr, "-- %s ", __FILE__); naic_debug(naic);
#endif

  if (naic->flags & NAIC_FLG_TERSE) {
    CHECK(naic->write(naic->write_arg, "  range 00 ff\n"));
  } else {
    CHECK(naic->write(naic->write_arg, "  any\n"));
  }
  ++(naic->capindex);
  return NAIG_OK;
}
