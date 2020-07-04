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

#include <stdlib.h>
#include <string.h>

#include <unistd.h>
#include <fcntl.h>

#include "../../lib/naigama/naig_private.h"

#include <naigama/naigama.h>
#include <naigama/util/util_functions.h>

NAIG_ERR_T naigama_run
  (char* grammar, unsigned char* data, unsigned data_length)
{
  naig_t naig;
  naig_result_t result;

  CHECK(naig_compile(&naig, grammar));
  CHECK(naig_run(&naig, data, data_length, &result));
  return NAIG_OK;
}

/**
 *
 */
int main
  (int argc, char* argv[])
{
  int i;
  FILE* output = stdout;
  char* grammar;
  unsigned grammar_length;
  unsigned char* data;
  unsigned data_length;
  NAIG_ERR_T e;
  char* gen = NAIG_GENERATION;

  for (i=0; i < argc; i++) {
    char* arg = argv[ i ];
    if (*arg == '-') {
      ++arg;
      switch (*arg) {
      case 'i':
        if (i < argc - 1) {
          char* path = argv[ ++i ];
          if (absorb_file(path, (unsigned char**)&grammar, &grammar_length)) {
            fprintf(stderr, "Could not absorb %s\n", path);
            exit(-3);
          }
        } else {
          fprintf(stderr, "-i requires an argument");
          exit(-1);
        }
        break;
      case 'I':
        if (i < argc - 1) {
          grammar = argv[ ++i ];
        } else {
          fprintf(stderr, "-I requires an argument");
          exit(-1);
        }
        break;
      case 'd':
        if (i < argc - 1) {
          char* path = argv[ ++i ];
          if (absorb_file(path, &data, &data_length)) {
            fprintf(stderr, "Could not absorb %s\n", path);
            exit(-3);
          }
        } else {
          fprintf(stderr, "-i requires an argument");
          exit(-1);
        }
        break;
      case 'D':
        if (i < argc - 1) {
          data = (unsigned char*)argv[ ++i ];
          data_length = strlen((char*)data);
        } else {
          fprintf(stderr, "-I requires an argument");
          exit(-1);
        }
        break;
      case 'o':
        if (i < argc - 1) {
          char* path = argv[ ++i ];
          if (0 == strcmp(path, "-")) {
            output = stdout;
          } else {
            if ((output = fopen(path, "w")) == NULL) {
              fprintf(stderr, "'%s' cannot be opened for writing.\n", path);
              exit(-1);
            }
          }
        } else {
          fprintf(stderr, "-o requires an argument");
          exit(-1);
        }
        break;
      default:
        fprintf(stderr, "Unknown switch -%c\n", *arg);
        __attribute__((fallthrough));
      case '?':
      case 'h':
        fprintf(stderr,
          "This is naig %s, the Naigama all in one engine.\n"
          "Usage: %s [options]\n"
          "Options:\n"
          "-? / -h      Display this message\n"
          "-i <path>    Grammar file (default or - is stdin)\n"
          "-I <grammar> Grammar text\n"
          "-d <path>    Input data file\n"
          "-D <text>    Input data text\n"
          "-o <path>    Output file (default or - is stdout)\n"
          "-O <format>  Output format (one of 'bin', 'csv', 'rpl').\n"
          , gen
          , argv[ 0 ]
        );
        exit(-1);
      }
    }
  }
  e = naigama_run(grammar, data, data_length);
  if (e.code) {
    exit(e.code);
  }
  return 0;
}
