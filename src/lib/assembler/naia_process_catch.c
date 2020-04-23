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
NAIG_ERR_T naia_process_catch
  (naia_t* naia, unsigned i)
{
  uint32_t opcode[ 2 ] = { htonl(OPCODE_CATCH) };
  uint32_t offset;

  CHECK(
    naia_label_get(
      naia,
      naia->assembly + naia->captures->actions[ i+1 ].start,
      naia->captures->actions[ i+1 ].stop
        - naia->captures->actions[ i+1 ].start,
      &offset
    )
  );
  opcode[ 1 ] = htonl(offset);
  CHECK(naia->write(opcode, sizeof(opcode), naia->write_arg));
  return NAIG_OK;
}
