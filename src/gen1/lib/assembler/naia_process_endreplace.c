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
NAIG_ERR_T naia_process_endreplace
  (naia_t* naia, unsigned i)
{
  uint32_t opcode = htonl(OPCODE_ENDREPLACE);
  (void)i;

  CHECK(naia->write(&opcode, sizeof(opcode), naia->write_arg));
  return NAIG_OK;
}
