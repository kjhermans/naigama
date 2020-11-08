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

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>

#include <unistd.h>
#include <fcntl.h>

#include "../../lib/naigama/naig_private.h"

#include <naigama/compiler/naic.h>
#include <naigama/util/util_functions.h>

static
NAIG_ERR_T naic_write_string
  (void* arg, char* fmt, ...)
{
  char** assembly = (char**)arg;
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
NAIG_ERR_T naic_write_bin
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

static
NAIG_ERR_T do_compile
  (
    char* grammar,
    unsigned flags,
    FILE* output,
    FILE* slotmap,
    FILE* slotmaph,
    int assemble,
    char* asmfile,
    FILE* labelmap
  )
{
  naic_slotmap_t map;
  char* assembly = 0;

  memset(&map, 0, sizeof(map));
  if (assemble) {
    fprintf(stderr, "Compiling...\n");
    CHECK(naic_compile(grammar, &map, flags, naic_write_string, &assembly));
    if (asmfile) {
      FILE* f = fopen(asmfile, "w");
      if (f) {
        fprintf(f, "%s", assembly);
        fclose(f);
      } else {
        fprintf(stderr, "WARNING: Could not emit assembly at '%s'\n", asmfile);
      }
    }
    fprintf(stderr, "Assembly...\n");
    CHECK(
      naia_assemble(
        assembly,
        labelmap,
        flags & NAIC_FLG_DEBUG,
        naic_write_bin,
        output
      )
    );
  } else {
    CHECK(naic_compile(grammar, &map, flags, naic_write_file, output));
  }
  if (slotmap) {
    CHECK(naic_slotmap_write(&map, slotmap));
    fclose(slotmap);
  }
  if (slotmaph) {
    CHECK(naic_slotmap_write_h(&map, slotmaph));
    fclose(slotmaph);
  }
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
  FILE* slotmaph = NULL;
  char* assembly = 0;
  FILE* labelmap = NULL;
  unsigned flags = 0;
  int i, assemble = 0;
  char* gen = NAIG_GENERATION;

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
        flags |= NAIC_FLG_DEBUG;
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
      case 'M':
        if (i < argc - 1) {
          char* path = argv[ i+1 ];
          slotmaph = fopen(path, "w");
          if (NULL == slotmaph) {
            fprintf(stderr, "Could not open %s\n", path);
            exit(-6);
          }
        }
        break;
      case 't':
        flags |= NAIC_FLG_TRAPS;
        break;
      case 'T':
        flags |= NAIC_FLG_TRADITIONAL;
        break;
      case 's':
        flags |= NAIC_FLG_TERSE;
        break;
      case 'w':
        flags |= NAIC_FLG_LOOPS;
        break;
      case 'b':
        assemble = 1;
        break;
      case 'a':
        assemble = 1;
        if (i < argc - 1) {
          assembly = argv[ i+1 ];
        } else {
          fprintf(stderr, "-a requires a path\n");
          exit(-6);
        }
        break;
      case 'l':
        if (i < argc - 1) {
          char* path = argv[ i+1 ];
          labelmap = fopen(path, "w");
          if (!labelmap) {
            fprintf(stderr, "Could not open labelmap file.\n");
            exit(-7);
          }
        } else {
          fprintf(stderr, "-l requires a path\n");
          exit(-6);
        }
        break;
      case '?':
      case 'h':
      default:
        fprintf(stderr,
          "This is naic %s, the Naigama grammar compiler program.\n"
          "Usage: %s [options]\n"
          "Options:\n"
          "-? / -h    Display this message\n"
          "-i <path>  Input grammar file (- for stdin)\n"
          "-o <path>  Output assembly file (- for, or otherwise stdout)\n"
          "-b         Incorporate the assembler and output bytecode at -o\n"
          "-a <path>  Emit bytecode at -o, and assembly at -a\n"
          "-m <path>  Output slotmap file (optional)\n"
          "-M <path>  Output slotmap.h file (optional)\n"
          "-l <path>  Labelmap path (only works when -a or -b is given).\n"
          "-D         Debug (prepare for a lot of data on stderr)\n"
          "-t         Generate traps\n"
          "-T         'Traditional' output (LPEG compatible)\n"
          "-s         Generate reduced instruction set\n"
          "-w         Write out loops instead of using counters\n"
          , gen
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
  NAIG_ERR_T e = do_compile(
    grammar, flags, output, slotmap, slotmaph, assemble, assembly, labelmap
  );
  return e.code;
}
