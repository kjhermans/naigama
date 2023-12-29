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
#include <ctype.h>

#include <naigama/util/queryargs.h>
#include <naigama/util/absorb_file.h>
#include <naigama/util/strxypos.h>
#include <naigama/engine/naie.h>

static
char* helpstring =
  "This is naic %s, the Naigama grammar assembly program.\n"
  "Usage: %s [options]\n"
  "Options:\n"
  "-? / -h      Display this message.\n"
  "-c <path>    Bytecode file.\n"
  "-i <path>    Input file (- for stdin).\n"
  "-D           Debug (prepare for a lot of data on stderr).\n"
;

static
NAIG_ERR_T naie_engine_debugger_simple
  (naie_t* naie, naie_ec_t* ec, uint32_t opcode, void* arg)
{
  (void)naie;
  (void)arg;

  unsigned i = 0;

  fprintf(stderr,
    "ins @%.6u:%.8x, inp @%.4u:%.2x "
    , ec->bytecode_offset
    , opcode
    , ec->input_offset
    , ec->input.data[ ec->input_offset ]
  );
  if (ec->stack.count > 4) {
    i = ec->stack.count - 4;
  }
  for (; i < ec->stack.count; i++) {
    naie_stackelt_t* e = naie_stack_getptr(&(ec->stack), i);
    switch (e->type) {
    case NAIE_STACK_CALL:
      fprintf(stderr, "%u:Ret@%.6u ", i, e->address);
      break;
    case NAIE_STACK_CATCH:
      fprintf(stderr, "%u:Alt@%.6u ", i, e->address);
      break;
    default:
      RETURNERR(NAIG_ERR_INTEGRITY);
    }
  }
  fprintf(stderr, "\n");
  return NAIG_OK;
}

int main
  (int argc, char* argv[])
{
  char* bytecodefile = 0;
  unsigned char* bytecode = 0;
  unsigned bytecode_length = 0;
  char* defaultinputfile = "-";
  char* inputfile = defaultinputfile;
  unsigned char* input = 0;
  unsigned input_length = 0;
  naie_t naie = { 0 };
  naie_ec_t ec = { 0 };
  NAIG_ERR_T e = { 0 };

  if (queryargs(argc, argv, '?', 0, 0, 0, 0) == 0
      || queryargs(argc, argv, 'h', 0, 0, 0, 0) == 0
      || queryargs(argc, argv, 0, "help", 0, 0, 0) == 0)
  {
    fprintf(stderr, helpstring, "", argv[ 0 ]);
    return 0;
  }

  queryargs(argc, argv, 'i', "input", 0, 1, &inputfile);

  if (absorb_file(inputfile, &input, &input_length)) {
    fprintf(stderr, "Input file (%s) reading error.\n", inputfile);
    return ~0;
  }

  e = naie_ec_init(&ec, input, input_length);
  if (!(NAIG_IS_OK(e))) {
    fprintf(stderr, "Error code %d: %s\n", e.code, ec.errorstr.data);
    return ~0;
  }

  if (queryargs(argc, argv, 'c', "bytecode", 0, 1, &bytecodefile)) {
    fprintf(stderr, "Need bytecode file. Use -c.\n");
    return ~0;
  }

  if (absorb_file(bytecodefile, &bytecode, &bytecode_length)) {
    fprintf(stderr, "Bytecode file (%s) reading error.\n", bytecodefile);
    return ~0;
  }

  e = naie_init(&naie, bytecode, bytecode_length);
  if (!(NAIG_IS_OK(e))) {
    fprintf(stderr, "Error code %d: %s\n", e.code, ec.errorstr.data);
    return ~0;
  }

  if (queryargs(argc, argv, 'D', "debug", 0, 0, 0) == 0) {
    naie.debugger = naie_engine_debugger_simple;
    naie.debugarg = 0;
  }

  e = naie_run(&naie, &ec);
  if (!(NAIG_IS_OK(e))) {

    if (e.code == NAIG_ERR_NOMATCH.code) {
      naie_stackelt_t e;
      unsigned i;
      unsigned yx[ 2 ];

      ec.stack.count = ec.stack_max;
      naie_stack_get_furthest(&(ec.stack), &i, &e);
      if (e.input_offset < input_length) {
        strxypos((char*)input, e.input_offset, yx);
        fprintf(stderr, "No match: furthest byte %u (line %u, offset %u)\n"
          , e.input_offset, yx[0], yx[1]
        );
        fprintf(stderr, "Input: ");
        for (unsigned i=0; i < 32 && i+e.input_offset < input_length; i++) {
          char c = input[ i+e.input_offset ];
          if (isprint(c)) {
            fprintf(stderr, "%c", c);
          } else {
            fprintf(stderr, "\\x%.2x", c);
          }
        }
        fprintf(stderr, "\n");
      }
    }

    fprintf(stderr, "Error code %d: %s\n", e.code, ec.errorstr.data);
    return ~0;
  }

  if (ec.errorstr.size) {
    fprintf(stderr, "There were warnings:\n %s\n", ec.errorstr.data);
  }

  TODO("Free the input and bytecode buffers");
  TODO("Free the naie and ec structures");

  return 0;
}
