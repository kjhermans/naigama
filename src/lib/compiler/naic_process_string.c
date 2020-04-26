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

static
NAIG_ERR_T naic_process_string_callback
  (naic_t* naic, unsigned chr)
{
  CHECK(naic->write(naic->write_arg, "  char %.2x\n", chr));
  return NAIG_OK;
}
  
/**
 *
 */
NAIG_ERR_T naic_process_string
  (naic_t* naic)
{
  unsigned start = naic->captures->actions[ naic->capindex ].start
         , stop = naic->captures->actions[ naic->capindex ].start +
                  naic->captures->actions[ naic->capindex ].length;

#ifdef _DEBUG
  fprintf(stderr, "-- %s ", __FILE__); naic_debug(naic);
#endif

  if (naic->grammar[ stop-1 ] == 'i') {
    return naic_process_string_caseinsensitive(naic);
  }
  CHECK(
    naic_string_unescape(
      naic,
      start+1,
      stop-1,
      naic_process_string_callback
    )
  );
  return NAIG_OK;
}
