/**
 * This file is part of Oroszlan, a parsing and scripting environment

Copyright (c) 2022, Kees-Jan Hermans <kees.jan.hermans@gmail.com>
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
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>

#include <naigama/compiler/naic.h>
#include <naigama/assembler/naia.h>
#include <naigama/engine/naie.h>
#include <naigama/memio/buf.h>
#include <naigama/util/util_functions.h>

static
int capture = 1;

static
NAIG_ERR_T naig_handle_capture
  (const unsigned char* orig, unsigned start, unsigned length, void* arg)
{
  naio_buf_t* copy = (naio_buf_t*)arg;

  if (capture) {
    NAIO_BUF_ADD(copy, orig + start, length);
  }
  return NAIG_OK;
}

static
NAIG_ERR_T naig_handle_delete
  (const unsigned char* orig, unsigned start, unsigned length, void* arg)
{
  naio_buf_t* copy = (naio_buf_t*)arg;
  (void)orig;

  memmove(
    copy->ptr + start,
    copy->ptr + start + length,
    copy->len - (start + length)
  );
  copy->len -= length;
  return NAIG_OK;
}

static
NAIG_ERR_T naig_handle_insert
  (
    const unsigned char* orig,
    unsigned typ,
    unsigned start,
    uint32_t chr,
    void* arg
  )
{
  naio_buf_t* copy = (naio_buf_t*)arg;
  (void)orig;

  switch (typ) {
  case NAIG_ACTION_REPLACE_CHAR:
    memmove(
      copy->ptr + start + 1,
      copy->ptr + start,
      copy->len - start
    );
    copy->ptr[ start ] = chr;
    copy->len += 1;
    break;
  case NAIG_ACTION_REPLACE_QUAD:
    memmove(
      copy->ptr + start + 4,
      copy->ptr + start,
      copy->len - start
    );
    memcpy(copy->ptr + start, &chr, 4);
    copy->len += 4;
    break;
  }
  return NAIG_OK;
}

static
NAIG_ERR_T naig_write_assembly
  (void* ptr, char* fmt, ...)
{
  naio_buf_t* buf = (naio_buf_t*)ptr;
  va_list ap;
  unsigned increase;

  va_start(ap, fmt);
  increase = vsnprintf(0, 0, fmt, ap);
  va_end(ap);
  if (increase < 1024) {
    increase = 1024;
  }
  NAIO_BUF_ROOM(buf, increase);
  va_start(ap, fmt);
  vsnprintf((char*)(&(buf->ptr[ buf->len ])), increase, fmt, ap);
  va_end(ap);
  buf->len = strlen((char*)(buf->ptr));
  return NAIG_OK;
}

static
NAIG_ERR_T naig_write_bytecode
  (void* ptr, unsigned size, void* arg)
{
  naio_buf_t* buf = (naio_buf_t*)arg;
  NAIO_BUF_ADD(buf, ptr, size);
  return NAIG_OK;
}

int main
  (int argc, char* argv[])
{
  int i;
  char** rules = malloc(sizeof(char*) * argc);
  unsigned nrules = 0;
  char* grammarfile = "-";
  char* inputfile = "-";
  char* grammar = 0;
  unsigned grammarlen = 0;
  naio_buf_t assembly = NAIO_BUF_INIT;
  naio_buf_t bytecode = NAIO_BUF_INIT;
  unsigned char* input = 0;
  unsigned inputlen = 0;
  unsigned compileflags = 0;
  char** paths = malloc(sizeof(char*) * argc);
  unsigned npaths = 0;
  naio_slotmap_t slots;
  naio_labelmap_t labelmap;
  naie_engine_t engine;
  naio_result_t result;
  int compileonly = 0;
  int assembleonly = 0;

  for (i=1; i < argc; i++) {
    char* arg = argv[ i ];
    if (*arg == '-') {
      switch (arg[ 1 ]) {
      case 'e':
        if (i >= argc - 1) {
          fprintf(stderr, "-e needs argument\n");
          exit(-1);
        }
        grammar = argv[ ++i ];
        break;
      case 'g':
        if (i >= argc - 1) {
          fprintf(stderr, "-g needs argument\n");
          exit(-1);
        }
        grammarfile = argv[ ++i ];
        break;
      case 'r':
        capture = !capture;
        break;
      case 'c':
        compileonly = 1;
        break;
      case 'a':
        assembleonly = 1;
        break;
      case 'i':
        if (i >= argc - 1) {
          fprintf(stderr, "-i needs argument\n");
          exit(-1);
        }
        inputfile = argv[ ++i ];
        break;
      case 'h': case '?':
        printf(
"%s [Options] { rules }\n"
"\n"
"Pocket knife command line executable wrt Naigama parsing.\n"
"\n"
"Options:\n"
"-i <path>  Input file (or - for stdin).\n"
"-g <path>  Grammar file (or - for stdin).\n"
"-e <expr>  Grammar expression.\n"
"-r         Perform replacements and output instead of capture and output.\n"
"-c         Compile only (output is assembly).\n"
"-a         Assemble only (output is bytecode).\n"
"-d         Assemble and then disassemble bytecode (output is assembly).\n"
"-? or -h   This text.\n"
, argv[ 0 ]
        );
        exit(0);
      default:
        fprintf(stderr, "Unknown cmldline switch '-%c'\n", arg[ i ]);
        exit(-1);
      }
    } else {
      rules[ nrules++ ] = argv[ i ];
    }
  }
  if (0 == grammar) {
    if (0 == strcmp(grammarfile, inputfile)) {
      fprintf(stderr, "Identical input and grammar files ('%s')\n", inputfile);
      exit(-1);
    }
    if (absorb_file(grammarfile, (unsigned char**)(&grammar), &grammarlen)) {
      fprintf(stderr, "Could not absorb grammar file ('%s')\n", grammarfile);
      exit(-1);
    }
  }
  if (absorb_file(inputfile, (unsigned char**)(&input), &inputlen)) {
    fprintf(stderr, "Could not absorb input file ('%s')\n", inputfile);
    exit(-1);
  }
#ifdef _DEBUG
  fprintf(stderr, "Start compiler.\n");
#endif
  if (!NAIG_ISOK(
        naic_compile(
          grammar,
          &slots,
          compileflags,
          paths,
          npaths,
          naig_write_assembly,
          &assembly
        )
      )
    )
  {
    fprintf(stderr, "Compiler error.\n");
    exit(-1);
  }
  if (compileonly) {
    fprintf(stdout, "%s\n", assembly.ptr);
    exit(0);
  }
#ifdef _DEBUG
  fprintf(stderr, "%s\nStart assembler.\n", assembly.ptr);
#endif
  if (!NAIG_ISOK(
        naia_assemble(
          (char*)(assembly.ptr),
          &labelmap,
          0,
          naig_write_bytecode,
          &bytecode
        )
      )
    )
  {
    fprintf(stderr, "Assembler error.\n");
    exit(-1);
  }
  if (assembleonly) {
    fwrite(bytecode.ptr, 1, bytecode.len, stdout);
    exit(0);
  }
#ifdef _DEBUG
  fprintf(stderr, "Initialize engine.\n");
#endif
  if (!NAIG_ISOK(
        naie_engine_init(
          &engine,
          bytecode.ptr,
          bytecode.len
        )
      )
    )
  {
    fprintf(stderr, "Engine init error.\n");
    exit(-1);
  }
  if (!capture) {
    engine.flags = NAIE_FLAG_DOREPLACE;
  }
  engine.labelmap = labelmap;
#ifdef _DEBUG
  fprintf(stderr, "Running engine.\n");
#endif
  if (0 == nrules) {
    if (!NAIG_ISOK(naie_engine_run(&engine, input, inputlen, &result)))
    {
      fprintf(stderr, "Engine running error.\n");
      exit(-1);
    }
    naio_buf_t ibuf = NAIO_BUF_INIT;
    if (!capture) {
      NAIO_BUF_ADD(&ibuf, input, inputlen);
      NAIO_BUF_ROOM(&ibuf, 1024);
    }
#ifdef _DEBUG
    fprintf(stderr, "Start result handler.\n");
#endif
    if (!NAIG_ISOK(
          naie_result_handle(
            &engine,
            &result,
            naig_handle_capture,
            naig_handle_delete,
            naig_handle_insert,
            &ibuf
          )
        )
      )
    {
      fprintf(stderr, "Result handling error.\n");
      exit(-1);
    }
    fprintf(stdout, "%-.*s", ibuf.len, ibuf.ptr);
  } else {
    unsigned i;
    naio_buf_t ibuf = NAIO_BUF_INIT;
    if (!capture) {
      NAIO_BUF_ADD(&ibuf, input, inputlen);
      NAIO_BUF_ROOM(&ibuf, 1024);
    }
    for (i=0; i < nrules; i++) {
      if (!NAIG_ISOK(naie_engine_call(&engine, rules[ i ], &result)))
      {
        fprintf(stderr, "Engine running error.\n");
        exit(-1);
      }
      if (!NAIG_ISOK(
            naie_result_handle(
              &engine,
              &result,
              naig_handle_capture,
              naig_handle_delete,
              naig_handle_insert,
              &ibuf
            )
          )
        )
      {
        fprintf(stderr, "Result handling error.\n");
        exit(-1);
      }
      engine.input = ibuf.ptr;
      engine.input_length = ibuf.len;
      ibuf = NAIO_BUF_INIT;
      NAIO_BUF_ADD(&ibuf, engine.input, engine.input_length);
      NAIO_BUF_ROOM(&ibuf, 1024);
    }
    fprintf(stdout, "%-.*s", ibuf.len, ibuf.ptr);
  }
  return 0;
}
