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

#include <naigama/assembler/naia.h>

/**
 * Topmost function
 */
NAIG_ERR_T naia_process_tokens
  (naia_t* naia)
{
#ifdef _DEBUG
  unsigned i;
  for (i=0; i < naia->captures->size; i++) {
    fprintf(stderr, "Token %u: %u-%u %s '%-.*s'\n"
      , i
      , naia->captures->actions[ i ].start
      , naia->captures->actions[ i ].stop
      , naia_slotmap_string(naia->captures->actions[ i ].slot)
      , naia->captures->actions[ i ].stop - naia->captures->actions[ i ].start
      , naia->assembly + naia->captures->actions[ i ].start
    );
  }
#endif

  CHECK(naia_process_labels(naia));
  CHECK(naia_process_instructions(naia));
  return NAIG_OK;
}
