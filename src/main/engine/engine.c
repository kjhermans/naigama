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

#include <unistd.h>
#include <fcntl.h>

#include <naigama/engine/naie.h>
#include <naigama/util/util_functions.h>

extern NAIG_ERR_T engine_replace
  (naie_engine_t* engine, naie_result_t* result, FILE* output);

static
void debug_output
  (naie_result_t* result, unsigned char* data)
{
  unsigned i;

  fprintf(stderr, "End code: %d\n", result->code);
  fprintf(stderr, "%u actions total\n", result->size);
  for (i=0; i < result->size; i++) {
    switch (result->actions[ i ].action) {
    case NAIG_ACTION_OPENCAPTURE:
      fprintf(stderr, "Action #%u: capture slot %u, %u->%u '%-.*s'\n"
        , i
        , result->actions[ i ].slot
        , result->actions[ i ].start
        , result->actions[ i ].length
        , result->actions[ i ].length
        , data + result->actions[ i ].start
      );
      break;
    case NAIG_ACTION_CLOSECAPTURE:
      break;
    case NAIG_ACTION_REPLACE_CHAR:
      fprintf(stderr, "Action #%u: replace slot %u, char %.2x\n"
        , i
        , result->actions[ i ].slot
        , result->actions[ i ].length
      );
      break;
    case NAIG_ACTION_REPLACE_QUAD:
      fprintf(stderr, "Action #%u: replace slot %u, quad %.8x\n"
        , i
        , result->actions[ i ].slot
        , result->actions[ i ].length
      );
      break;
    }
  }
}

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
    if (debug) { engine.debug = 1; }
    if (diligent) { engine.diligent = 1; }
    if (replace) { engine.doreplace = 1; }
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
      debug_output(&result, data);
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
