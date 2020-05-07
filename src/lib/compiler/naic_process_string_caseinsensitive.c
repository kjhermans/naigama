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
NAIG_ERR_T naic_process_string_callback_i
  (naic_t* naic, unsigned chr, int last)
{
  (void)last;

  if (chr >= 'a' && chr <= 'z') {
    //..
  } else if (chr >= 'A' && chr <= 'Z') {
    //..
  } else {
    CHECK(naic->write(naic->write_arg, "  char %.2x\n", chr));
  }
  return NAIG_OK;
}

/**
 *
 */
NAIG_ERR_T naic_process_string_caseinsensitive
  (naic_t* naic)
{
  unsigned start = naic->captures->actions[ naic->capindex ].start
         , stop = naic->captures->actions[ naic->capindex ].start +
                  naic->captures->actions[ naic->capindex ].length;

#ifdef _DEBUG
  fprintf(stderr, "-- %s ", __FILE__); naic_debug(naic);
#endif

  CHECK(
    naic_string_unescape(
      naic,
      start+1,
      stop-1,
      naic_process_string_callback_i
    )
  );
  return NAIG_OK;
}
