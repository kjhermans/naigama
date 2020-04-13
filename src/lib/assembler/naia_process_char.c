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
NAIG_ERR_T naia_process_char
  (naia_t* naia, unsigned i)
{
  uint32_t opcode[ 2 ] = { htonl(OPCODE_CHAR) };
  uint32_t chr = 0;
  unsigned char* _chr = (unsigned char*)(&chr);
  size_t s;

  _chr[ 3 ] = hexcodon(
    naia->assembly[ naia->captures->actions[ i+1 ].start ],
    naia->assembly[ naia->captures->actions[ i+1 ].start+1 ]
  );
  if (i+2 < naia->captures->size
      && naia->captures->actions[ i+2 ].slot == ASMSLOT_HEXBYTE_AFAF)
  {
    _chr[ 1 ] = hexcodon(
      naia->assembly[ naia->captures->actions[ i+2 ].start ],
      naia->assembly[ naia->captures->actions[ i+2 ].start+1 ]
    );
  }
  opcode[ 1 ] = chr;
  if ((s = fwrite(&opcode, sizeof(uint32_t), 2, naia->output)) == 2) {
    return NAIG_OK;
  } else {
    RETURNERR(NAIG_ERR_WRITE);
  }
}
