/**
 * This file is part of Oroszlan, a parsing and scripting environment

Copyright (c) 2023, Kees-Jan Hermans <kees.jan.hermans@gmail.com>
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the organization nor the
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
#include <string.h>
#include <stdint.h>

#include <naigama/util/queryargs.h>
#include <naigama/assembler/naia.h>

static
char* helpstring =
  "This is naic %s, the Naigama grammar assembly program.\n"
  "Usage: %s [options]\n"
  "Options:\n"
  "-? / -h      Display this message\n"
  "-i <path>    Input assembly file (- for stdin)\n"
  "-o <path>    Output bytecode file (- for, or otherwise stdout)\n"
  "-l <path>    Labelmap path\n"
  "-D           Debug (prepare for a lot of data on stderr)\n"
;

int main
  (int argc, char* argv[])
{
  FILE* output = stdout;
  char* defaultinputfile = "-";
  char* inputfile = defaultinputfile;
  char* labelmap = 0;
  naia_t naia;
  NAIG_ERR_T e;

  memset(&naia, 0, sizeof(naia));
  if (queryargs(argc, argv, '?', 0, 0, 0, 0) == 0
      || queryargs(argc, argv, 'h', 0, 0, 0, 0) == 0
      || queryargs(argc, argv, 0, "help", 0, 0, 0) == 0)
  {
    fprintf(stderr, helpstring, "", argv[ 0 ]);
    return 0;
  }
  queryargs(argc, argv, 'i', "input", 0, 1, &inputfile);
  {
    char* outputfile;
    if (queryargs(argc, argv, 'o', "output", 0, 1, &outputfile) == 0) {
      if (0 == strcmp(outputfile, "-")) {
        output = stdout;
      } else if ((output = fopen(outputfile, "w")) == NULL) {
        fprintf(stderr, "Could not open '%s' for output\n", outputfile);
        return ~0;
      }
    }
  }
  queryargs(argc, argv, 'l', "labelmap", 0, 1, &labelmap);

  naia.output.file = output;
  e = naia_assemble(&naia, inputfile);
  if (!(NAIG_IS_OK(e))) {
    fprintf(stderr, "Error code %d: %s\n", e.code, naia.errorstr.data);
    return ~0;
  }

  if (naia.errorstr.size) {
    fprintf(stderr, "There were warnings:\n %s\n", naia.errorstr.data);
  }

  fwrite(naia.output.string.data, 1, naia.output.string.size, output);
  fclose(output);

  if (labelmap) {
    e = naia_labelmap_write(&naia, labelmap);
    if (e.code) {
      fprintf(stderr, "Error writing labelmap (code %d).\n", e.code);
    }
  }

  naia_free(&naia);

  return 0;
}
