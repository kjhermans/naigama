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
NAIG_ERR_T naia_process_set
  (naia_t* naia, unsigned i)
{
  uint32_t opcode[ 9 ] = { htonl(OPCODE_SET) };
  unsigned char* set = (unsigned char*)(&(opcode[ 1 ]));
  unsigned c;
  unsigned char none[ 32 ] = { 0 };
  unsigned char all[ 32 ] = { 255 };

  for (c=0; c < 32; c++) {
    set[ c ] = hexcodon(
      naia->assembly[ naia->captures->actions[ i+1 ].start + (c*2) ],
      naia->assembly[ naia->captures->actions[ i+1 ].start + (c*2) + 1 ]
    );
  }
  if (0 == memcmp(set, none, sizeof(none))) {
    fprintf(stderr, "WARNING: Set matches no input byte (empty set).\n");
  }
  if (0 == memcmp(set, all, sizeof(all))) {
    fprintf(stderr, "WARNING: Set matches all input bytes (full set).\n");
  }
  CHECK(naia->write(opcode, sizeof(opcode), naia->write_arg));
  return NAIG_OK;
}
