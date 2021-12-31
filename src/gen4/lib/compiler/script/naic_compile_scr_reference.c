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

#include "../naic_private.h"

/**
 *
 */
NAIG_ERR_T naic_compile_scr_reference
  (naic_t* naic, naio_resobj_t* reference)
{
  NAIG_ERR_T e;
  naic_nspnod_t* nsp = naic->currentscope, * entry;
  naio_resobj_t* ident;
  naio_resobj_t* ndx;
  naio_resobj_t* ndxexpr;
  naio_resobj_t* subref;
  char* name;
  unsigned i = 0;

  ident = naio_resobj_query(reference, 1, SLOT_IDENT, i++);

if (ident == NULL) { naic_resobj_debug(reference); }
  ASSERT(ident != NULL)

  name = ident->string;
  if (!(NAIG_ISOK(e = naic_nsp_get(nsp, name, &entry, 1)))) {
    snprintf(naic->error, sizeof(naic->error),
      "Reference to '%s' not found.", name
    );
    return NAIG_ERR_NOTFOUND;
  }
  if (entry->type != NAIC_NSPTYPE_CODEVAR
      && entry->type != NAIC_NSPTYPE_CODEGLOBAL)
  {
    snprintf(naic->error, sizeof(naic->error),
      "Reference to '%s'; not a variable.", name
    );
    return NAIG_ERR_NOTFOUND;
  }
  NAIC_WRITE("  scr_push { %d }\n", entry->value.codevar.reg);
  i = 0;
  while ((ndx = naio_resobj_query(reference, 1, SLOT_INDEX, i++)) != NULL) {
    ndxexpr = naio_resobj_query(ndx, 1, SLOT_SCR_EXPRESSION, 0);
    CHECK(naic_compile_expr(naic, ndxexpr));
    NAIC_WRITE("  scr_index\n");
  }
  if ((subref = naio_resobj_query(reference, 1, SLOT_SCR_REFERENCE, 0)) != NULL)
  {
    //..
  }
  return NAIG_OK;
}
