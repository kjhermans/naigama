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
 * TESTCHARINSTR <- { 'testchar' } S HEXBYTE S LABEL ( S AMPERSAND HEXBYTE )?
 */
NAIG_ERR_T naia_process_testchar
  (naia_t* naia, unsigned i)
{
  uint32_t opcode[ 2 ] = { htonl(OPCODE_TESTCHAR) };
  uint32_t chr = 0;
  uint32_t offset;
  unsigned char* _chr = (unsigned char*)(&chr);
  size_t s;

  _chr[ 3 ] = hexcodon(
    naia->assembly[ naia->captures->actions[ i+1 ].start ],
    naia->assembly[ naia->captures->actions[ i+1 ].start+1 ]
  );
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
  if (i+3 < naia->captures->size
      && naia->captures->actions[ i+3 ].slot == ASMSLOT_HEXBYTE_AFAF)
  {
    _chr[ 1 ] = hexcodon(
      naia->assembly[ naia->captures->actions[ i+3 ].start ],
      naia->assembly[ naia->captures->actions[ i+3 ].start+1 ]
    );
  }
  opcode[ 2 ] = chr;
  if ((s = fwrite(&opcode, sizeof(uint32_t), 3, naia->output)) == 3) {
    return NAIG_OK;
  } else {
    RETURNERR(NAIG_ERR_WRITE);
  }
}
