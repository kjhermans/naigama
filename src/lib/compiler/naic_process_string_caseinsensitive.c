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
NAIG_ERR_T naic_write_set
  (naic_t* naic, unsigned char set[ 32 ])
{
  unsigned i;

  CHECK(naic->write(naic->write_arg, "  set "));
  for (i=0; i < 32; i++) {
    CHECK(naic->write(naic->write_arg, "%.2x", set[ i ]));
  }
  CHECK(naic->write(naic->write_arg, "\n"));
  return NAIG_OK;
}

static
NAIG_ERR_T naic_process_string_callback_i
  (naic_t* naic, unsigned chr, int last)
{
  unsigned alt;
  (void)last;
  unsigned char set[ 32 ] = { 0 };

  if (chr >= 'a' && chr <= 'z') {
    alt = 'A' + (chr - 'a');
    NAIC_SET_BIT_SET(set, chr);
    NAIC_SET_BIT_SET(set, alt);
    CHECK(naic_write_set(naic, set));
  } else if (chr >= 'A' && chr <= 'Z') {
    alt = 'a' + (chr - 'A');
    NAIC_SET_BIT_SET(set, chr);
    NAIC_SET_BIT_SET(set, alt);
    CHECK(naic_write_set(naic, set));
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
                  naic->captures->actions[ naic->capindex ].length - 1;

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
