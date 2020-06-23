/**
 * This file is part of Naigama, a parser engine.
 * Copyright 2020, KJ Hermans
 * Written by KJ Hermans <kees.jan.hermans@gmail.com>
 *
 * LICENSE:
 * Withheld
 *
 * \file
 * \brief
 */

#include <stdlib.h>
#include <string.h>

#include <unistd.h>
#include <fcntl.h>

#include "../../lib/naigama/naig_private.h"

#include <naigama/engine/naie.h>
#include <naigama/util/util_functions.h>

extern NAIG_ERR_T engine_replace
  (naie_engine_t* engine, naie_result_t* result, FILE* output);

/**
 *
 */
int main
  (int argc, char* argv[])
{
  int i, debug = 0, diligent = 0, stringpos = 0, replace = 0, suppress = 0;;
  FILE* output = stdout;
  unsigned char* bytecode = 0;
  unsigned bytecode_length = 0;
  //unsigned stacksize = 256;
  unsigned char* data = 0;
  unsigned data_length = 0;
  char* labelmap = 0;
  naie_engine_t engine;
  naie_result_t result;

  for (i=0; i < argc; i++) {
    char* arg = argv[ i ];
    if (*arg == '-') {
      ++arg;
      switch (*arg) {
      case 'b':
        if (i < argc - 1) {
          char* path = argv[ i+1 ];
          if (absorb_file(path, &bytecode, &bytecode_length)) {
            fprintf(stderr, "Could not absorb %s\n", path);
            exit(-3);
          }
        }
        break;
      case 'd':
        if (i < argc - 1) {
          char* path = argv[ i+1 ];
          if (absorb_file(path, &data, &data_length)) {
            fprintf(stderr, "Could not absorb %s\n", path);
            exit(-4);
          }
        }
        break;
      case 'l':
        if (i < argc - 1) {
          labelmap = argv[ i+1 ];
        } else {
          fprintf(stderr, "Labelmap file isn't given.\n");
          exit(-5);
        }
        break;
      case 'o':
        if (i < argc - 1) {
          char* path = argv[ i+1 ];
          if (0 == strcmp(path, "-")) {
            output = stdout;
          } else if (NULL == (output = fopen(path, "w"))) {
            fprintf(stderr, "Could not open %s\n", path);
            exit(-2);
          }
        }
        break;
      case 'X':
        diligent = !diligent;
        break;
      case 'D':
        if (bytecode) { logmem(bytecode, bytecode_length); }
        if (data) { logmem(data, data_length); }
        debug = 1;
        suppress = 1;
        break;
      case 'I':
        stringpos = !stringpos;
        break;
      case 'r':
        replace = !replace;
        suppress = 1;
        break;
      case 'S':
        suppress = !suppress;
        break;
      case 's':
        fprintf(stderr, "Stack size not supported.\n"); exit(-1);
/*
        if (i < argc - 1) {
          int s = atoi(argv[ ++i ]);
          if (s > 0) {
            stacksize = s;
            break;
          }
        }
        __attribute__((fallthrough));
*/
      case '?':
      case 'h':
      default:
        fprintf(stderr,
          "This is naie, the Naigama bytecode execution engine.\n"
          "Usage: %s [options]\n"
          "Options:\n"
          "-? / -h    Display this message\n"
          "-b <path>  Bytecode file\n"
          "-d <path>  Data file\n"
          "-o <path>  Output file (otherwise stdout)\n"
          "-l <path>  Labelmap file\n"
          "-r         Perform replacements and output result\n"
          "-S         Suppress binary output (implicit in -D and -r)\n"
          "-D         Debug (prepare for a lot of data on stderr)\n"
          "-X         Diligent (gather stats while running)\n"
          "-I         Input is a string. Text position is displayed on error\n"
          "-s <size>  Stack size\n"
          , argv[ 0 ]
        );
        exit(-1);
      }
    }
  }
  if (bytecode && data) {
    NAIG_ERR_T e;
    e = naie_engine_init(
      &engine,
      bytecode,
      bytecode_length,
      data,
      data_length
    );
    if (e.code) {
      return -1;
    }
    if (debug) { engine.flags |= NAIE_FLAG_DEBUG; }
    if (diligent) { engine.flags |= NAIE_FLAG_DILIGENT; }
    if (replace) { engine.flags |= NAIE_FLAG_DOREPLACE; }
    if (labelmap) {
      e = naie_set_labelmap(&engine, labelmap);
      if (e.code) {
        fprintf(stderr, "Labelmap set error %d\n", e.code);
        return -1;
      }
    }
    e = naie_engine_run(
      &engine,
      &result
    );
    if (e.code) {
      fprintf(stderr, "Error %u\n", e.code);
      if (stringpos) {
        unsigned xy[ 2 ];
        if (strxypos((char*)data, engine.input_pos, xy) == 0) {
          fprintf(stderr, "Error at line %u, char %u in input\n", xy[0], xy[1]);
        }
      }
      if (debug) {
        engine.stack.size = engine.stacksizebeforefail;
        naie_debug_state(&engine, 1);
      }
      return -1;
    }
    if (debug) {
      naie_result_debug(&result, data);
    }
    if (diligent) {
      fprintf(stderr, "Number of instructions: %u\n", engine.noinstructions);
      fprintf(stderr, "Max stack depth: %u\n", engine.maxstackdepth);
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
    fprintf(stderr, "No bytecode or data (%p %p)\n", bytecode, data);
    return ~0;
  }
  return 0;
}