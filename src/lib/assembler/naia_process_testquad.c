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
 * TESTQUADINSTR      <- { 'testquad' } S QUAD S LABEL
 */
NAIG_ERR_T naia_process_testquad
  (naia_t* naia, unsigned i)
{
  uint32_t opcode[ 3 ] = { htonl(OPCODE_TESTQUAD) };
  uint32_t offset;
  uint32_t chr = 0;
  unsigned char* _chr = (unsigned char*)(&chr);
  size_t s;

  CHECK(
    naia_label_get(
      naia,
      naia->assembly + naia->captures->actions[ i+2 ].start,
      naia->captures->actions[ i+2 ].stop
        - naia->captures->actions[ i+2 ].start,
      &offset
    )
  );
  opcode[ 1 ] = htonl(offset);
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
  opcode[ 2 ] = chr;
  if ((s = fwrite(&opcode, sizeof(uint32_t), 3, naia->output)) == 3) {
    return NAIG_OK;
  } else {
    RETURNERR(NAIG_ERR_WRITE);
  }
}
