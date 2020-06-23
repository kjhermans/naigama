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

#include <string.h>

#include "nasc_private.h"

static
unsigned char bytecode[] = BYTECODE;

/**
 * Compiles the script, and writes the script assembly to
 * the writer function. Of the writer functions, there are
 * default implementations, that either work on file descriptors
 * (writing to a file), or to a reallocating string.
 *
 * \param code    Zero terminated, none NULL string pointer,
 *                containing the script source code.
 * \param writer  Writer callback, to which the script assembly
 *                is written using the *printf family of function
 *                (hence the elipsis).
 * \param arg     Argument provided by the caller, to be passed to
 *                the writer callback.
 *
 * \returns       NAIG_OK on success, or a naigama error on error.
 */
NAIG_ERR_T nasc_compile
  (char* code, NAIG_ERR_T(*writer)(void*,char*,...), void* arg)
{
  NAIG_ERR_T e;
  naie_engine_t engine;
  naie_result_t result;

  CHECK(
    naie_engine_init(
      &engine,
      bytecode,
      sizeof(bytecode),
      (const unsigned char*)code,
      strlen(code)
    )
  );
  e = naie_engine_run(&engine, &result);
  if (e.code) {
    if (e.code == 1) {
      unsigned yx[ 2 ];
      if (strxypos(code, engine.input_pos, yx) == 0) {
        fprintf(stderr, "Script parsing error line %u, off %u\n", yx[0], yx[1]);
      } else {
        fprintf(stderr, "Script parsing error.\n");
      }
    }
    return e;
  }
#ifdef _DEBUG
  naie_result_debug(&result, (unsigned char*)code);
#endif
  nasc_t nasc = {
    .code = code,
    .captures = &result
  };
  CHECK(nasc_process_tokens(&nasc, writer, arg));
  return NAIG_OK;
}
