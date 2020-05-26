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
NAIG_ERR_T naic_process_hexliteral
  (naic_t* naic)
{
  unsigned chr = hexcodon(
    naic->grammar[ naic->captures->actions[ naic->capindex ].start + 2 ],
    naic->grammar[ naic->captures->actions[ naic->capindex ].start + 3 ]
  );

#ifdef _DEBUG
  fprintf(stderr, "-- %s ", __FILE__); naic_debug(naic);
#endif

  CHECK(naic->write(naic->write_arg, "  char %.2x\n", chr));
  return NAIG_OK;
}
