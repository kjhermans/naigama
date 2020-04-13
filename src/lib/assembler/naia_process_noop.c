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
NAIG_ERR_T naia_process_noop
  (naia_t* naia, unsigned i)
{
  uint32_t opcode = htonl(OPCODE_NOOP);
  size_t s = fwrite(&opcode, sizeof(opcode), 1, naia->output);
  (void)i;

  if (s == 1) {
    return NAIG_OK;
  } else {
    RETURNERR(NAIG_ERR_WRITE);
  }
}
