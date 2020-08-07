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
DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
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

#include "naig_private.h"

static
NAIG_ERR_T naig_write_assembly
  (void* ptr, char* fmt, ...)
{
  char** assembly = (char**)ptr;
  va_list ap;
  char* realc;
  unsigned len;

  if (*assembly) {
    len = strlen(*assembly);
  } else {
    len = 0;
  }
  realc = (char*)realloc(*assembly, len + 1024);
  va_start(ap, fmt);
  vsnprintf(realc + len, 1024, fmt, ap);
  va_end(ap);
  *assembly = realc;
  return NAIG_OK;
}

static
NAIG_ERR_T naig_write_bytecode
  (void* ptr, unsigned size, void* arg)
{
  naig_t* naig = (naig_t*)arg;
  unsigned char* newbc =
    (unsigned char*)realloc(naig->bytecode, naig->bytecode_length + size);

  naig->bytecode = newbc;
  memcpy(naig->bytecode + naig->bytecode_length, ptr, size);
  naig->bytecode_length += size;
  return NAIG_OK;
}

/**
 *
 */
NAIG_ERR_T naig_compile
  (naig_t* naig, char* grammar)
{
  char* assembly = NULL;

  CHECK(
    naic_compile(
      grammar,
      &(naig->slotmap),
      0,
      0,
      naig_write_assembly,
      &assembly
    )
  );
  if (naig->debug) {
    fprintf(stderr, "%s\n", assembly);
  }
  CHECK(
    naia_assemble(
      assembly,
      NULL,
      0,
      naig_write_bytecode,
      naig
    )
  );
  free(assembly);
  return NAIG_OK;
}
