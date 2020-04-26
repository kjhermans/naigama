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
 * TESTSETINSTR       <- { 'testset' } S SET S LABEL
 */
NAIG_ERR_T naia_process_testset
  (naia_t* naia, unsigned i)
{
  uint32_t opcode[ 10 ] = { htonl(OPCODE_TESTSET) };
  unsigned char* set = (unsigned char*)(&(opcode[ 2 ]));
  unsigned c;
  uint32_t offset;

  CHECK(
    naia_label_get(
      naia,
      naia->assembly + naia->captures->actions[ i+2 ].start,
      naia->captures->actions[ i+2 ].length,
      &offset
    )
  );
  opcode[ 1 ] = htonl(offset);
  for (c=0; c < 32; c++) {
    set[ c ] = hexcodon(
      naia->assembly[ naia->captures->actions[ i+1 ].start + (c*2) ],
      naia->assembly[ naia->captures->actions[ i+1 ].start + (c*2) + 1 ]
    );
  }
  CHECK(naia->write(opcode, sizeof(opcode), naia->write_arg));
  return NAIG_OK;
}
