/**
 * This file is part of Naigama, a parser engine.

Copyright (c) 2020, Kees-Jan Hermans <kees.jan.hermans@gmail.com>
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the <organization> nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL Kees-Jan Hermans BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

 *
 * \file
 * \brief
 */

#include "naia_private.h"

/**
 * TESTQUADINSTR      <- { 'testquad' } S QUAD S LABEL
 */
NAIG_ERR_T naia_process_testquad
  (naia_t* naia, naio_resobj_t* object)
{
  uint32_t opcode[ 3 ] = { SET_32BIT_VALUE(OPCODE_TESTQUAD) };
  uint32_t offset;
  uint32_t chr = 0;
  unsigned char* _chr = (unsigned char*)(&chr);

  CHECK(
    naia_namespace_resolve(
      naia,
      object->children[ 2 ]->string,
      object->children[ 2 ]->stringlen,
      &offset
    )
  );
  opcode[ 1 ] = SET_32BIT_VALUE(offset);
  _chr[ 0 ] = hexcodon(
    object->children[ 1 ]->string[ 0 ],
    object->children[ 1 ]->string[ 1 ]
  );
  _chr[ 1 ] = hexcodon(
    object->children[ 1 ]->string[ 3 ],
    object->children[ 1 ]->string[ 4 ]
  );
  _chr[ 2 ] = hexcodon(
    object->children[ 1 ]->string[ 5 ],
    object->children[ 1 ]->string[ 6 ]
  );
  _chr[ 3 ] = hexcodon(
    object->children[ 1 ]->string[ 7 ],
    object->children[ 1 ]->string[ 8 ]
  );
  opcode[ 2 ] = chr;
  CHECK(naia->write(opcode, sizeof(opcode), naia->write_arg));
  return NAIG_OK;
}
