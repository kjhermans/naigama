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
NAIG_ERR_T naia_process_span
  (naia_t* naia, unsigned i)
{
  uint32_t opcode[ 9 ] = { htonl(OPCODE_SPAN) };
  unsigned char* set = (unsigned char*)(&(opcode[ 1 ]));
  unsigned c;

  for (c=0; c < 32; c++) {
    set[ c ] = hexcodon(
      naia->assembly[ naia->captures->actions[ i+1 ].start + (c*2) ],
      naia->assembly[ naia->captures->actions[ i+1 ].start + (c*2) + 1 ]
    );
  }
  CHECK(naia->write(opcode, sizeof(opcode), naia->write_arg));
  return NAIG_OK;
}
