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

  reg = atoi_substr(
    naia->assembly,
    naia->captures->actions[ i+1 ].start,
    naia->captures->actions[ i+1 ].length
  );
  opcode[ 1 ] = htonl(reg);
  num = atoi_substr(
    naia->assembly,
    naia->captures->actions[ i+2 ].start,
    naia->captures->actions[ i+2 ].length
  );
  opcode[ 2 ] = htonl(num);
  CHECK(naia->write(opcode, sizeof(opcode), naia->write_arg));
  return NAIG_OK;
}
