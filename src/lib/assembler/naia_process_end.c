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
 * ENDINSTR           <- { 'end' } (S CODE )?
 */
NAIG_ERR_T naia_process_end
  (naia_t* naia, unsigned i)
{
  uint32_t opcode[ 2 ] = { htonl(OPCODE_END) };
  uint32_t endcode = 0;
  size_t s;

  if (i+1 < naia->captures->size
      && naia->captures->actions[ i+1 ].slot == ASMSLOT_NUMBER)
  {
    endcode = atoi_substr(
      naia->assembly,
      naia->captures->actions[ i+1 ].start,
      naia->captures->actions[ i+1 ].stop
        - naia->captures->actions[ i+1 ].start
    );
  }
  opcode[ 1 ] = htonl(endcode);
  if ((s = fwrite(&opcode, sizeof(uint32_t), 2, naia->output)) == 2) {
    return NAIG_OK;
  } else {
    RETURNERR(NAIG_ERR_WRITE);
  }
}
