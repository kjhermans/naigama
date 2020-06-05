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

#include "naia_private.h"

/**
 *
 */
NAIG_ERR_T naia_process_testany
  (naia_t* naia, unsigned i)
{
  uint32_t opcode[ 2 ] = { htonl(OPCODE_TESTANY) };
  uint32_t offset;

  CHECK(
    naia_label_get(
      naia,
      naia->assembly + naia->captures->actions[ i+1 ].start,
      naia->captures->actions[ i+1 ].length,
      &offset
    )
  );
  opcode[ 1 ] = htonl(offset);
  CHECK(naia->write(opcode, sizeof(opcode), naia->write_arg));
  return NAIG_OK;
}
