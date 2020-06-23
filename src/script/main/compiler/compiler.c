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

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>

#include <unistd.h>
#include <fcntl.h>

#include <naigama/engine/naie.h>
#include <naigama/script/compiler/nasc.h>
#include <naigama/util/util_functions.h>

#include "../../../parser/gen1/lib/engine/naie_private.h"

static
NAIG_ERR_T naic_write_file
  (void* arg, char* fmt, ...)
{
  FILE* file = (FILE*)arg;
  va_list ap;

  va_start(ap, fmt);
  vfprintf(file, fmt, ap);
  va_end(ap);
  return NAIG_OK;
}

/**
 *
 */
int main
  (int argc, char* argv[])
{
  char* code = 0;
  unsigned code_length = 0;
  FILE* output = stdout;
  int i, debug, traps;

#ifdef _DEBUG
  fprintf(stderr, "Welcome to %s\n", argv[ 0 ]);
#endif
  for (i=0; i < argc; i++) {
    char* arg = argv[ i ];
    if (*arg == '-') {
      ++arg;
      switch (*arg) {
      case 'i':
        if (i < argc - 1) {
          char* path = argv[ i+1 ];
          if (absorb_file(path, (unsigned char**)(&code), &code_length)) {
            fprintf(stderr, "Could not absorb %s\n", path);
            exit(-3);
          }
        }
        break;
      case 'D':
        debug = 1;
        break;
      case 'o':
        if (i < argc - 1) {
          char* path = argv[ i+1 ];
          if (0 == strcmp(path, "-")) {
            output = stdout;
          } else {
            output = fopen(path, "w");
            if (NULL == output) {
              fprintf(stderr, "Could not open %s\n", path);
              exit(-2);
            }
          }
        }
        break;
      case 't':
        traps = 1;
        break;
      case '?':
      case 'h':
      default:
        fprintf(stderr,
          "This is naic, the Naigama code compiler program.\n"
          "Usage: %s [options]\n"
          "Options:\n"
          "-? / -h    Display this message\n"
          "-i <path>  Input code file (- for stdin)\n"
          "-o <path>  Output assembly file (- for, or otherwise stdout)\n"
          "-D         Debug (prepare for a lot of data on stderr)\n"
          "-t         Generate traps\n"
          , argv[ 0 ]
        );
        exit(-1);
      }
    }
  }

  (void)debug; (void)traps;

  if (code == 0 || code_length == 0) {
    fprintf(stderr, "No code given.\n");
    exit(-1);
  }
  NAIG_ERR_T e = nasc_compile(code, naic_write_file, output);
  return e.code;
}
