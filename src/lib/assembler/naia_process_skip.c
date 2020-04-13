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
 * SKIPINSTR          <- { 'skip' } S NUMBER
 */
NAIG_ERR_T naia_process_skip
  (naia_t* naia, unsigned i)
{
  uint32_t opcode[ 2 ] = { htonl(OPCODE_SKIP) };
  uint32_t num = 0;
  size_t s;

  num = atoi_substr(
    naia->assembly,
    naia->captures->actions[ i+1 ].start,
    naia->captures->actions[ i+1 ].stop
      - naia->captures->actions[ i+1 ].start
  );
  opcode[ 1 ] = htonl(num);
  if ((s = fwrite(&opcode, sizeof(uint32_t), 2, naia->output)) == 2) {
    return NAIG_OK;
  } else {
    RETURNERR(NAIG_ERR_WRITE);
  }
}
