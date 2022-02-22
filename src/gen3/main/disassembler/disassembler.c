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

#include <naigama/disassembler/naid.h>
#include <naigama/util/util_functions.h>
#include <naigama/release.h>

static
NAIG_ERR_T naid_write_file
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
  unsigned char* bytecode = 0;
  unsigned bytecode_len = 0;
  FILE* output = stdout;
  int i;
  char* gen = NAIG_GENERATION;

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
          char* path = argv[ ++i ];
          if (absorb_file(path, (unsigned char**)(&bytecode), &bytecode_len)) {
            fprintf(stderr, "Could not absorb %s\n", path);
            exit(-1);
          }
        } else {
          fprintf(stderr, "-i requires an argument\n");
          exit(-2);
        }
        break;
      case 'D':
//        debug = 1;
        break;
      case 'o':
        if (i < argc - 1) {
          char* path = argv[ ++i ];
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
      case '?':
      case 'h':
      default:
        fprintf(stderr,
          "This is naid %s, the Naigama disassembler program.\n"
          "Usage: %s [options]\n"
          "Options:\n"
          "-? / -h    Display this message\n"
          "-i <path>  Input bytecode file (or - for stdin)\n"
          "-o <path>  Output assembly file (- for, or otherwise stdout)\n"
          "-D         Debug (prepare for a lot of data on stderr)\n"
          , gen
          , argv[ 0 ]
        );
        exit(-7);
      }
    }
  }
  if (bytecode == 0 || bytecode_len == 0) {
    fprintf(stderr, "No bytecode given.\n");
    exit(-8);
  }
  NAIG_ERR_T e =
    naid_disassemble(bytecode, bytecode_len, naid_write_file, output);
  return e.code;
}
