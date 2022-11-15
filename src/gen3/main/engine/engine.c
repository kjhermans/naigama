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

#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#include <unistd.h>
#include <fcntl.h>
#include <signal.h>

#include <naigama/engine/naie.h>
#include <naigama/util/util_functions.h>
#include <naigama/naig_private.h>
#include <naigama/release.h>

extern NAIG_ERR_T engine_replace
  (naie_engine_t* engine, naio_result_t* result, FILE* output);

extern NAIG_ERR_T engine_debug_cont
  (naie_engine_t* engine, uint32_t, void*);

extern NAIG_ERR_T engine_debug_fuzz
  (naie_engine_t* engine, uint32_t, void*);

extern NAIG_ERR_T engine_debug_inputoffset
  (naie_engine_t* engine, uint32_t, void*);

extern NAIG_ERR_T engine_debug_report
  (naie_engine_t* engine, uint32_t opcode, void* arg);

static
naie_engine_t engine;

static
void engine_debug_signal
  (int signum)
{
  fprintf(stderr, "Interrupted on signal %d.\n", signum);
  engine.debugstate = NAIE_DEBUG_HALT;
}

/**
 *
 */
int main
  (int argc, char* argv[])
{
  int i, debug = 0, diligent = 0, stringpos = 0, replace = 0, suppress = 0, tree = 0;
  FILE* output = stdout;
  unsigned char* bytecode = 0;
  unsigned bytecode_length = 0;
  unsigned stacksize = 256;
  unsigned actionsize = 1024;
  unsigned regsize = 32;
  unsigned char* data = 0;
  unsigned data_length = 0;
  char* labelmap = 0;
  char* slotmap = 0;
  naio_result_t result;
  char* gen = NAIG_GENERATION;
  int debugmode = 0, fuzzer = 0, endless = 0;
  int superverbose = 0;

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
      case 'c':
        if (i < argc - 1) {
          char* path = argv[ ++i ];
          if (absorb_file(path, &bytecode, &bytecode_length)) {
            fprintf(stderr, "Could not absorb %s\n", path);
            exit(-3);
          }
        }
        break;
      case 'i':
        if (i < argc - 1) {
          char* path = argv[ ++i ];
          if (absorb_file(path, &data, &data_length)) {
            fprintf(stderr, "Could not absorb %s\n", path);
            exit(-4);
          }
        }
        break;
      case 'l':
        if (i < argc - 1) {
          labelmap = argv[ ++i ];
        } else {
          fprintf(stderr, "Labelmap file isn't given.\n");
          exit(-5);
        }
        break;
      case 'm':
        if (i < argc - 1) {
          slotmap = argv[ ++i ];
        } else {
          fprintf(stderr, "Slotmap file isn't given.\n");
          exit(-5);
        }
        break;
      case 'o':
        if (i < argc - 1) {
          char* path = argv[ ++i ];
          if (0 == strcmp(path, "-")) {
            output = stdout;
          } else if (NULL == (output = fopen(path, "w"))) {
            fprintf(stderr, "Could not open %s\n", path);
            exit(-2);
          }
        }
        break;
      case 'x':
        diligent = !diligent;
        break;
      case 'v':
        if (bytecode) { flogmem(stderr, bytecode, bytecode_length); }
        if (data) { flogmem(stderr, data, data_length); }
        debug = 1;
        suppress = 1;
        break;
      case 'V':
        if (bytecode) { flogmem(stderr, bytecode, bytecode_length); }
        if (data) { flogmem(stderr, data, data_length); }
        debug = 1;
        suppress = 1;
        superverbose = 1;
        break;
      case 'I':
        stringpos = !stringpos;
        break;
      case 'r':
        replace = !replace;
        suppress = 1;
        break;
      case 'e':
        endless = 1;
        break;
      case 'S':
        suppress = !suppress;
        break;
      case 's':
        if (i < argc - 1) {
          int s = atoi(argv[ ++i ]);
          if (s > 0) {
            stacksize = s;
            break;
          }
        } else {
          fprintf(stderr, "Stacksize needs a parameter.\n");
          exit(-1);
        }
        break;
      case 'd':
        debugmode = 1;
        break;
      case 'f':
        fuzzer = 1;
        break;
      case 't':
        tree = 1;
        break;
      case '?':
      case 'h':
      default:
        fprintf(stderr,
          "This is naie %s, the Naigama bytecode execution engine.\n"
          "Usage: %s [options]\n"
          "Options:\n"
          "-? / -h     Display this message\n"
          "-c <path>   Bytecode file\n"
          "-i <path>   Data input file\n"
          "-o <path>   Output file (otherwise stdout)\n"
          "-l <path>   Labelmap file\n"
          "-m <path>   Slotmap file\n"
          "-r          Perform replacements and output result\n"
          "-S          Suppress binary output (implicit in -v and -r)\n"
          "-d          Start debugger\n"
          "-v          Verbose (prepare for a lot of data on stderr)\n"
          "-V          Super verbose (see above)\n"
          "-t          Provide capture tree at the end\n"
          "-x          Diligent (gather stats while running)\n"
          "-f <path>   Fuzzer; produce fuzzed inputs in directory <path>\n"
          "-I          Input is a string. Text position is displayed on error\n"
          "-s <size>   Stack size\n"
          "-e          Toggle endless loop checking (default %s)\n"
          , gen
          , argv[ 0 ]
          , ((NAIE_FLAGS_DEFAULT & NAIE_FLAG_ENDLESS) ? "on" : "off")
        );
        exit(-1);
      }
    }
  }
  if (bytecode) {
    NAIG_ERR_T e;
    e = naie_engine_init(
      &engine,
      bytecode,
      bytecode_length
    );
    engine.flags = NAIE_FLAGS_DEFAULT;
    if (e.code) {
      return -1;
    }
    {
      void* mem = malloc(stacksize * sizeof(naie_stackentry_t));
      engine.stack.entries = mem;
      engine.stack.length = stacksize;
    }
    {
      void* mem = malloc(actionsize * sizeof(naie_action_t));
      engine.actions.entries = mem;
      engine.actions.length = actionsize;
    }
    {
      void* mem = malloc(regsize * sizeof(naie_register_t));
      engine.reg.entries = mem;
      engine.reg.length = regsize;
    }
    if (debug) { engine.flags |= NAIE_FLAG_DEBUG; }
    if (diligent) { engine.flags |= NAIE_FLAG_DILIGENT; }
    if (replace) { engine.flags |= NAIE_FLAG_DOREPLACE; }
    if (endless) {
      if (engine.flags & NAIE_FLAG_ENDLESS) {
        engine.flags &= ~(NAIE_FLAG_ENDLESS);
      } else {
        engine.flags |= NAIE_FLAG_ENDLESS;
      }
    }
    if (labelmap) {
      e = naio_labelmap_load(&(engine.labelmap), labelmap);
      if (e.code) {
        fprintf(stderr, "Labelmap set error %d\n", e.code);
        return -1;
      }
    }
    if (slotmap) {
      e = naio_slotmap_load(slotmap, &(engine.slotmap));
      if (e.code) {
        fprintf(stderr, "Slotmap set error %d\n", e.code);
        return -1;
      }
    }
    if (debugmode) {
      signal(SIGINT, engine_debug_signal);
      engine.debugger = engine_debug_inputoffset;
      engine.debugoffset = 0;
    } else if (superverbose) {
      engine.debugger = engine_debug_report;
    } else if (debug) {
      engine.debugger = engine_debug_cont;
    } else if (fuzzer) {
      engine.debugger = engine_debug_fuzz;
    }
    {
      unsigned j;
      for (j=0; j < engine.input_length; j++) {
        if (!isspace(engine.input[ j ]) && !isprint(engine.input[ j ])) {
          engine.flags |= NAIE_FLAG_HEXDEBUG;
        }
      }
    }
    e = naie_engine_run(
      &engine,
      data,
      data_length,
      &result
    );
    if (e.code) {
      fprintf(stderr,
        "Error %d %s (%s)\n", e.code, naig_error(e), naig_error_explicit(e)
      );
      if (stringpos) {
        unsigned xy[ 2 ];
        if (strxypos((char*)data, engine.input_pos, xy) == 0) {
          fprintf(stderr, "Error at line %u, char %u in input\n", xy[0], xy[1]);
        }
      }
      if (debug) {
        engine.stack.count =
          engine.forensics.maxstackdepth; //stacksizebeforefail;
        naie_debug_state(&engine, 1, 1);
      }
      return -1;
    }
    if (debug) {
      naio_result_debug(&result, data);
    }
    if (tree) {
      naio_resobj_t* obj =
        naio_result_object(engine.input, engine.input_length, &result);
      naio_result_object_debug(obj, 0);
    }
    if (diligent) {
      fprintf(stderr, "Number of instructions: %u\n"
        , engine.forensics.noinstructions
      );
      fprintf(stderr, "Max stack depth: %u\n"
        , engine.forensics.maxstackdepth
      );
    }
    if (!suppress) {
      e = naie_output(&result, output);
    }
    if (replace) {
      e = engine_replace(&engine, &result, output);
    }
    if (e.code) {
      fprintf(stderr, "Output writing error.\n");
      return -1;
    }
  } else {
    fprintf(stderr, "No bytecode\n");
    return ~0;
  }
  return 0;
}
