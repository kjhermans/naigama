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
 * CONDJUMPINSTR      <- { 'condjump' } S REGISTER S LABEL
 */
NAIG_ERR_T naia_process_condjump
  (naia_t* naia, unsigned i)
{
  uint32_t opcode[ 3 ] = { htonl(OPCODE_CONDJUMP) };
  uint32_t reg;
  uint32_t offset;
  size_t s;

  reg = atoi_substr(
    naia->assembly,
    naia->captures->actions[ i+1 ].start,
    naia->captures->actions[ i+1 ].stop
      - naia->captures->actions[ i+1 ].start
  );
  opcode[ 1 ] = htonl(reg);
  CHECK(
    naia_label_get(
      naia,
      naia->assembly + naia->captures->actions[ i+2 ].start,
      naia->captures->actions[ i+2 ].stop
        - naia->captures->actions[ i+2 ].start,
      &offset
    )
  );
  opcode[ 2 ] = htonl(offset);
  if ((s = fwrite(&opcode, sizeof(uint32_t), 3, naia->output)) == 3) {
    return NAIG_OK;
  } else {
    RETURNERR(NAIG_ERR_WRITE);
  }
}
