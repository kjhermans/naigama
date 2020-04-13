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
NAIG_ERR_T naia_process_quad
  (naia_t* naia, unsigned i)
{
  uint32_t opcode[ 2 ] = { htonl(OPCODE_QUAD) };
  uint32_t chr = 0;
  unsigned char* _chr = (unsigned char*)(&chr);
  size_t s;

  _chr[ 0 ] = hexcodon(
    naia->assembly[ naia->captures->actions[ i+1 ].start ],
    naia->assembly[ naia->captures->actions[ i+1 ].start+1 ]
  );
  _chr[ 1 ] = hexcodon(
    naia->assembly[ naia->captures->actions[ i+1 ].start+2 ],
    naia->assembly[ naia->captures->actions[ i+1 ].start+3 ]
  );
  _chr[ 2 ] = hexcodon(
    naia->assembly[ naia->captures->actions[ i+1 ].start+4 ],
    naia->assembly[ naia->captures->actions[ i+1 ].start+5 ]
  );
  _chr[ 3 ] = hexcodon(
    naia->assembly[ naia->captures->actions[ i+1 ].start+6 ],
    naia->assembly[ naia->captures->actions[ i+1 ].start+7 ]
  );
  opcode[ 1 ] = chr;
  if ((s = fwrite(&opcode, sizeof(uint32_t), 2, naia->output)) == 2) {
    return NAIG_OK;
  } else {
    RETURNERR(NAIG_ERR_WRITE);
  }
}
