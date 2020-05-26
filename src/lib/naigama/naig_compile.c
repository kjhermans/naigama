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

#include "naig_private.h"

static
NAIG_ERR_T naig_write_assembly
  (void* ptr, char* fmt, ...)
{
  char** assembly = (char**)ptr;
  va_list ap;
  char* realc;
  unsigned len = strlen(*assembly);

  realc = (char*)realloc(*assembly, len + 1024);
  va_start(ap, fmt);
  vsnprintf(realc, len + 1024, fmt, ap);
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
      NULL,
      0,
      0,
      naig_write_assembly,
      &assembly
    )
  );
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
