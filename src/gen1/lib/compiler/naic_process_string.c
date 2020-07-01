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

static
NAIG_ERR_T naic_process_string_callback
  (naic_t* naic, unsigned chr, int last)
{

#ifdef _NAIC_DONT_OPTIMIZE
  (void)last;
  CHECK(naic->write(naic->write_arg, "  char %.2x\n", chr));
#else

  unsigned i;

  if (naic->quad.nbytes == 3) {
    naic->quad.tmpvalue |= (unsigned char)chr;
    CHECK(
      naic->write(
        naic->write_arg,
        "  quad %.8x\n",
        naic->quad.tmpvalue
      )
    );
    naic->quad.tmpvalue = 0;
    naic->quad.nbytes = 0;
  } else if (last) {
    for (i=0; i < naic->quad.nbytes; i++) {
      CHECK(
        naic->write(
          naic->write_arg, "  char %.2x\n",
          ((unsigned char)(naic->quad.tmpvalue >> ((3 - i) * 8)))
        )
      );
    }
    CHECK(naic->write(naic->write_arg, "  char %.2x\n", chr));
  } else {
    naic->quad.tmpvalue |=
      (((unsigned char)chr) << ((3 - naic->quad.nbytes) * 8));
    ++(naic->quad.nbytes);
  }
#endif
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
