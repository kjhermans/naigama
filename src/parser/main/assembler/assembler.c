/**
 * This file is part of NAIG.
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

#include <unistd.h>
#include <fcntl.h>

#include "../lib/naigama/naig_private.h"

#include <naigama/assembler/naia.h>
#include <naigama/util/util_functions.h>

static
NAIG_ERR_T naia_write_file
  (void* ptr, unsigned size, void* arg)
{
  FILE* file = (FILE*)arg;
  size_t s;

  if ((s = fwrite(ptr, 1, size, file)) != size) {
    RETURNERR(NAIG_ERR_WRITE);
  }
  return NAIG_OK;
}

/**
 *
 */
int main
  (int argc, char* argv[])
{
  char* assembly = 0;
  unsigned assembly_len = 0;
  FILE* output = stdout;
  FILE* labelmap = NULL;
  int i, debug = 0;

  for (i=0; i < argc; i++) {
    char* arg = argv[ i ];
    if (*arg == '-') {
      ++arg;
      switch (*arg) {
      case 'i':
        if (i < argc - 1) {
          char* path = argv[ i+1 ];
          if (absorb_file(path, (unsigned char**)(&assembly), &assembly_len)) {
            fprintf(stderr, "Could not absorb %s\n", path);
            exit(-1);
          }
        } else {
          fprintf(stderr, "-i requires an argument\n");
          exit(-2);
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
              fprintf(stderr, "Could not open %s for output\n", path);
              exit(-3);
            }
          }
        } else {
          fprintf(stderr, "-o requires an argument\n");
          exit(-4);
        }
        break;
      case 'l':
        if (i < argc - 1) {
          char* path = argv[ i+1 ];
          labelmap = fopen(path, "w");
          if (NULL == labelmap) {
            fprintf(stderr, "Could not open %s for labelmap\n", path);
            exit(-5);
          }
        } else {
          fprintf(stderr, "-l requires an argument\n");
          exit(-6);
        }
        break;
      case '?':
      case 'h':
      default:
        fprintf(stderr,
          "This is naia, the Naigama assembler program.\n"
          "Usage: %s [options]\n"
          "Options:\n"
          "-? / -h    Display this message\n"
          "-i <path>  Input assembly file (or - for stdin)\n"
          "-o <path>  Output bytecode file (- for, or otherwise stdout)\n"
          "-l <path>  Emit labelmap at <path>\n"
          "-D         Debug (prepare for a lot of data on stderr)\n"
          , argv[ 0 ]
        );
        exit(-7);
      }
    }
  }
  if (assembly == 0 || assembly_len == 0) {
    fprintf(stderr, "No assembly given.\n");
    exit(-8);
  }
  NAIG_ERR_T e =
    naia_assemble(assembly, labelmap, debug, naia_write_file, output);
  return e.code;
}
