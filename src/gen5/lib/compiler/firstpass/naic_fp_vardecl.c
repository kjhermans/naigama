/**
 * This file is part of Oroszlan, a parsing and scripting environment

Copyright (c) 2021, Kees-Jan Hermans <kees.jan.hermans@gmail.com>
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

#include <naigama/engine/naie.h>
#include <naigama/naig_private.h>
#include "../naic_private.h"

/**
 *
 */
NAIG_ERR_T naic_fp_vardecl
  (naic_t* naic, naio_resobj_t* var, naic_nspnod_t* nsp)
{
  naic_nspnod_t* nspnod;
  naio_resobj_t* name;
  naio_resobj_t* type;
  (void)naic;

  name = naio_resobj_query(var, 1, SLOT_IDENT, 0);
  type = naio_resobj_query(var, 2, SLOT_SCR_TYPE, 0, SLOT_IDENT, 0);

  ASSERT(name != NULL)

  CHECK(
    naic_nsp_add_var(
      nsp, name->string, ( type ? type->string : NULL ), var, &nspnod
    )
  );
  var->auxptr = nspnod;
  return NAIG_OK;
}
