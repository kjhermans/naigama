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

#include <naigama/util/queryargs.h>
#include <naigama/compiler/naic.h>

static
char* helpstring =
  "This is naic %s, the Naigama grammar compiler program.\n"
  "Usage: %s [options]\n"
  "Options:\n"
  "-? / -h      Display this message\n"
  "-i <path>    Input grammar file (- for stdin)\n"
  "-o <path>    Output assembly file (- for, or otherwise stdout)\n"
  "-b           Incorporate the assembler and output bytecode at -o\n"
  "-a <path>    Emit bytecode at -o, and assembly at -a\n"
  "-m <path>    Output slotmap file (optional)\n"
  "-M <path>    Output slotmap.h file (optional)\n"
  "-l <path>    Labelmap path (only works when -a or -b is given).\n"
  "-D           Debug (prepare for a lot of data on stderr)\n"
  "-t --Ftr     Generate traps\n"
  "-w --Fwl     Write out loops instead of using counters\n"
  "-C --Fdc     Produce a default capture for every rule\n"
  "-O --Fop     Optimize the assembly\n"
  "-r --Fsr     Sets-as-ranges; never produce the 'set' instruction\n"
  "-I <path>    Add path for import purposes\n"
;

int main
  (int argc, char* argv[])
{
  FILE* output = stdout;
  char* defaultinputfile = "-";
  char* inputfile = defaultinputfile;
  char* slotmap = 0;
  char* slotmaph = 0;
  naic_t naic;
  NAIG_ERR_T e;

  memset(&naic, 0, sizeof(naic));
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
  if (queryargs(argc, argv, 'C', "Fdc", 0, 0, 0) == 0) {
    naic.flags |= NAIC_FLG_DEFAULTCAPTURE;
  }
  if (queryargs(argc, argv, 'O', "Fop", 0, 0, 0) == 0) {
    naic.flags |= NAIC_FLG_OPTIMIZE;
  }
  if (queryargs(argc, argv, 'r', "Fsr", 0, 0, 0) == 0) {
    naic.flags |= NAIC_FLG_SETSASRANGES;
  }
  queryargs(argc, argv, 'm', "slotmap", 0, 1, &slotmap);
  queryargs(argc, argv, 'M', "slotmap.h", 0, 1, &slotmaph);

  naic.output.file = output;
  e = naic_compile(&naic, inputfile);
  if (!(NAIG_IS_OK(e))) {
    fprintf(stderr, "Error code %d: %s\n", e.code, naic.errorstr.data);
    return ~0;
  }
  e = naic_nsp_string(
    &(naic.namespace.top),
    &(naic.output.string)
  );
  if (!(NAIG_IS_OK(e))) {
    fprintf(stderr, "Error code %d: %s\n", e.code, naic.errorstr.data);
    return ~0;
  }
  fprintf(output, "%s\n", naic.output.string.data);
  fclose(output);

  if (naic.errorstr.size) {
    fprintf(stderr, "There were warnings:\n %s\n", naic.errorstr.data);
  }

  if (slotmap) {
    naic_slotmap_write(&naic, slotmap);
  }
  if (slotmaph) {
    naic_slotmap_write_header(&naic, slotmaph);
  }

  return 0;
}
