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
NAIG_ERR_T naia_process_replace
  (naia_t* naia, unsigned i)
{
  uint32_t opcode[ 3 ] = { htonl(OPCODE_REPLACE) };
  uint32_t offset1;
  uint32_t offset2;

  CHECK(
    naia_label_get(
      naia,
      naia->assembly + naia->captures->actions[ i+1 ].start,
      naia->captures->actions[ i+1 ].stop
        - naia->captures->actions[ i+1 ].start,
      &offset1
    )
  );
  opcode[ 1 ] = htonl(offset1);
  CHECK(
    naia_label_get(
      naia,
      naia->assembly + naia->captures->actions[ i+2 ].start,
      naia->captures->actions[ i+2 ].stop
        - naia->captures->actions[ i+2 ].start,
      &offset2
    )
  );
  opcode[ 2 ] = htonl(offset2);
  CHECK(naia->write(opcode, sizeof(opcode), naia->write_arg));
  return NAIG_OK;
}
