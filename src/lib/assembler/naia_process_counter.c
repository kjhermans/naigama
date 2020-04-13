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
 * COUNTERINSTR       <- { 'counter' } S REGISTER S NUMBER
 */
NAIG_ERR_T naia_process_counter
  (naia_t* naia, unsigned i)
{
  uint32_t opcode[ 3 ] = { htonl(OPCODE_COUNTER) };
  uint32_t reg;
  uint32_t num;
  size_t s;

  reg = atoi_substr(
    naia->assembly,
    naia->captures->actions[ i+1 ].start,
    naia->captures->actions[ i+1 ].stop
      - naia->captures->actions[ i+1 ].start
  );
  opcode[ 1 ] = htonl(reg);
  num = atoi_substr(
    naia->assembly,
    naia->captures->actions[ i+2 ].start,
    naia->captures->actions[ i+2 ].stop
      - naia->captures->actions[ i+2 ].start
  );
  opcode[ 2 ] = htonl(num);
  if ((s = fwrite(&opcode, sizeof(uint32_t), 3, naia->output)) == 3) {
    return NAIG_OK;
  } else {
    RETURNERR(NAIG_ERR_WRITE);
  }
}
