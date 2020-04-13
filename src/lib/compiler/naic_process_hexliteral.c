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
NAIG_ERR_T naic_process_hexliteral
  (naic_t* naic)
{
  unsigned chr = hexcodon(
    naic->grammar[ naic->captures->actions[ naic->capindex ].start + 1 ],
    naic->grammar[ naic->captures->actions[ naic->capindex ].start + 2 ]
  );

#ifdef _DEBUG
  fprintf(stderr, "-- %s ", __FILE__); naic_debug(naic);
#endif

  fprintf(naic->output, "  char %.2x\n", chr);
  return NAIG_OK;
}
