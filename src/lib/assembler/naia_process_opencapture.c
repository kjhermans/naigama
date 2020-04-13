/**
 * This file is part of Naigama, a parser engine.
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
 *
 */
NAIG_ERR_T naia_process_opencapture
  (naia_t* naia, unsigned i)
{
  uint32_t opcode[ 2 ] = { htonl(OPCODE_OPENCAPTURE) };
  uint32_t slot;
  size_t s;

  slot = atoi_substr(
    naia->assembly,
    naia->captures->actions[ i+1 ].start,
    naia->captures->actions[ i+1 ].stop
      - naia->captures->actions[ i+1 ].start
  );
  opcode[ 1 ] = htonl(slot);
  if ((s = fwrite(&opcode, sizeof(uint32_t), 2, naia->output)) == 2) {
    return NAIG_OK;
  } else {
    RETURNERR(NAIG_ERR_WRITE);
  }
}
