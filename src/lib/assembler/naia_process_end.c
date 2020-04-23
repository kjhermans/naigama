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
  CHECK(naia->write(opcode, sizeof(opcode), naia->write_arg));
  return NAIG_OK;
}
