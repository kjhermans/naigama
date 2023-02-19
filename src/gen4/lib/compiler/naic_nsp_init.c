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

#include "naic_private.h"

/**
 * Initializes a namespace
 */
NAIG_ERR_T naic_nsp_init
  (naic_nsp_t* nsp, char* name)
{
  ASSERT(nsp != NULL);

  memset(nsp, 0, sizeof(*nsp));
  if (name) {
    if ((nsp->name = strdup(name)) == NULL) {
      RETURNERR(NAIG_ERR_MEM);
    }
  }
  return NAIG_OK;
}

/**
 * Mallocs a new namespace.
 */
NAIG_ERR_T naic_nsp_new
  (naic_nsp_t** nsp, char* name)
{
  (*nsp) = malloc(sizeof(naic_nsp_t));
  NAIG_CHECK(naic_nsp_init(*nsp, name), PROPAGATE);
  return NAIG_OK;
}

static
int naic_nsp_free_callback
  (naic_nsplist_t* list, unsigned i, naic_nsp_t** nsp, void* arg)
{
  (void)list;
  (void)i;
  (void)arg;

  naic_nsp_free(*nsp);
  free(*nsp);
  return 0;
}

/**
 * Frees a compiler namespace.
 */
void naic_nsp_free
  (naic_nsp_t* nsp)
{
  ASSERT(nsp != NULL);

  if (nsp->name) {
    free(nsp->name);
    nsp->name = 0;
  }
  naic_instrlist_free(&(nsp->instructions));
  naic_nsplist_iterate(&(nsp->children), naic_nsp_free_callback, 0);
  naic_nsplist_free(&(nsp->children));
}
