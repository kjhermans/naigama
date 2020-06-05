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

#include "../lib/naigama/naig_private.h"

#include <naigama/compiler/naic.h>
#include <naigama/util/util_functions.h>

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
  char* grammar = 0;
  unsigned grammar_length = 0;
  FILE* output = stdout;
  FILE* slotmap = NULL;
  int i, debug = 0, traps = 0;

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
          if (absorb_file(path, (unsigned char**)(&grammar), &grammar_length)) {
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
      case 'm':
        if (i < argc - 1) {
          char* path = argv[ i+1 ];
          slotmap = fopen(path, "w");
          if (NULL == slotmap) {
            fprintf(stderr, "Could not open %s\n", path);
            exit(-5);
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
          "This is naic, the Naigama grammar compiler program.\n"
          "Usage: %s [options]\n"
          "Options:\n"
          "-? / -h    Display this message\n"
          "-i <path>  Input grammar file (- for stdin)\n"
          "-o <path>  Output assembly file (- for, or otherwise stdout)\n"
          "-m <path>  Output slotmap file (optional)\n"
          "-D         Debug (prepare for a lot of data on stderr)\n"
          "-t         Generate traps\n"
          , argv[ 0 ]
        );
        exit(-1);
      }
    }
  }
  if (grammar == 0 || grammar_length == 0) {
    fprintf(stderr, "No grammar given.\n");
    exit(-1);
  }
  NAIG_ERR_T e;
  if (slotmap) {
    naic_slotmap_t map;
    map.size = 0;
    e = naic_compile(grammar, &map, debug, traps, naic_write_file, output);
    if (e.code == 0) { e = naic_slotmap_write(&map, slotmap); }
  } else {
    e = naic_compile(grammar, NULL, debug, traps, naic_write_file, output);
  }
  return e.code;
}
