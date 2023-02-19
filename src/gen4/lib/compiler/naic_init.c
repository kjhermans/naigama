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
 *
 */
NAIG_ERR_T naic_init
  (naic_t* naic, char* grammar)
{
  ASSERT(naic != NULL);

  memset(naic, 0, sizeof(*naic));
  if (grammar) {
    if ((naic->grammar = strdup(grammar)) == 0) {
      RETURNERR(NAIG_ERR_MEM);
    }
  }
  return NAIG_OK;
}

/**
 *
 */
NAIG_ERR_T naic_set_grammar
  (naic_t* naic, char* grammar)
{
  ASSERT(naic != NULL);

  if (naic->grammar) {
    free(naic->grammar);
    naic->grammar = 0;
  }
  if (0 == grammar) {
    RETURNERR(NAIG_ERR_NOTFOUND);
  }
  if ((naic->grammar = strdup(grammar)) == 0) {
    RETURNERR(NAIG_ERR_MEM);
  }
  return NAIG_OK;
}

/**
 *
 */
NAIG_ERR_T naic_set_output
  (naic_t* naic, FILE* file)
{
  ASSERT(naic != NULL);

  if (0 == file) {
    RETURNERR(NAIG_ERR_NOTFOUND);
  }
  naic->output.file = file;
  return NAIG_OK;
}

/**
 *
 */
void naic_free
  (naic_t* naic)
{
  ASSERT(naic != NULL);

  if (naic->grammar) {
    free(naic->grammar);
    naic->grammar = 0;
  }
  naic_nsp_free(&(naic->namespace.top));
  stringlist_free(&(naic->paths));
}
