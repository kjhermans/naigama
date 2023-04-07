/**
 * This file is part of Oroszlan, a parsing and scripting environment

Copyright (c) 2023, Kees-Jan Hermans <kees.jan.hermans@gmail.com>
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the organization nor the
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

#include <naigama/parser/naip.h>
#include <naigama/naigama/naig_functions.h>
#include <naigama/util/absorb_file.h>
#include <naigama/util/strxypos.h>

static unsigned char assembly_bytecode[] = {
#include "../../grammar/assembly.h"
};

/**
 * Topmost, API access function.
 * Assembles the instruction source code in a file
 * to a binary format, stored in naia->output.string.
 *
 * \param naia  Initialized assembler structure.
 * \param path  Path of the file containing the instruction source code.
 * \returns     NAIG_OK on success, and a NAIG_ERR_T code on failure.
 */
NAIG_ERR_T naia_assemble
  (naia_t* naia, char* path)
{
  DEBUGFUNCTION;
  ASSERT(naia);
  ASSERT(path);

  char* assembly;
  unsigned len;
  int r;
  naip_t naip;
  naip_actionlist_t actions;

  if (absorb_file(path, (unsigned char**)(&assembly), &len)) {
    td_printf(&(naia->errorstr), "Could not absorb '%s'.\n", path);
    RETURNERR(NAIG_ERR_NOTFOUND);
  }

  if ((r = naip_parse(
             &naip,
             assembly_bytecode,
             sizeof(assembly_bytecode),
             assembly,
             &actions)) != 0)
  {
    unsigned yx[ 2 ];
    if (strxypos(assembly, naip.error_offset, yx) == 0) {
      td_printf(
        &(naia->errorstr),
        "Assembly parsing error, code %d, file '%s', line %u, offset %u\n"
        , naip.error_code
        , path
        , yx[ 0 ]
        , yx[ 1 ]
      );
    }
  }

  naig_resobj_t* obj = naip_result_object(
    (unsigned char*)assembly,
    strlen(assembly),
    &actions
  );

  NAIG_CHECK(naia_fp(naia, obj), PROPAGATE);
  NAIG_CHECK(naia_sp(naia, obj), PROPAGATE);

  naig_result_object_free(obj);

  return NAIG_OK;
}
