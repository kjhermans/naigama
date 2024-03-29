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

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <unistd.h>
#include <fcntl.h>

#include <naigama/naig_private.h>

#include <naigama/compiler/naic.h>
#include <naigama/assembler/naia.h>
#include <naigama/util/util_functions.h>
#include <naigama/release.h>

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

static
int cfile_prefix = 0;

static
NAIG_ERR_T naia_write_cfile
  (void* ptr, unsigned size, void* arg)
{
  FILE* file = (FILE*)arg;
  unsigned char* _ptr = ptr;
  unsigned i;

  if (!cfile_prefix) {
    fprintf(file, "#define BYTECODE \\\n");
    cfile_prefix = 1;
  }

  for (i=0; i < size; i++) {
    fprintf(file, "0x%.2x, ", _ptr[ i ]);
    if (((i + 1) % 8) == 0) {
      fprintf(file, "\\\n");
    }
  }
  if ((i % 8) != 0) {
    fprintf(file, "\\\n");
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
  char* gen = NAIG_GENERATION;
  int genc = 0;

#ifdef _DEBUG
  fprintf(stderr,
    "%s generation " NAIG_GENERATION
    " release " NAIGAMA_RELEASE " debug version.\n", argv[ 0 ]
  );
#endif

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
      case 'c':
        genc = 1;
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
          "This is naia %s, the Naigama assembler program.\n"
          "Usage: %s [options]\n"
          "Options:\n"
          "-? / -h    Display this message\n"
          "-i <path>  Input assembly file (or - for stdin)\n"
          "-o <path>  Output bytecode file (- for, or otherwise stdout)\n"
          "-l <path>  Emit labelmap at <path>\n"
          "-D         Debug (prepare for a lot of data on stderr)\n"
          "-c         Output bytecode as C array.\n"
          , gen
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
  NAIG_ERR_T e = naia_assemble(
    assembly,
    labelmap,
    debug,
    (genc ? naia_write_cfile : naia_write_file),
    output
  );
  if (e.code) {
    fprintf(stderr, "Assembler error code %d\n", e.code);
  }
  return e.code;
}
