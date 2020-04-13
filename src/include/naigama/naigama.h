#ifndef _NAIGAMA_H_
#define _MAIGAMA_H_

#include <naigama/compiler/naic.h>
#include <naigama/assembler/naia.h>
#include <naigama/engine/naie.h>

// DON'T USE - NOT FINISHED

/*
 * Defines
 */

/*
 * Types
 */

typedef struct
{
  char*                         grammar;
  unsigned char*                bytecode;
  unsigned                      bytecode_length;
}
naig_t;

typedef struct
{
  naie_result_t                 result;
}
naig_result_t;

/*
 * Functions
 */

int naig_init_malloc
  (naig_t* naig);

int naig_init_mem
  (naig_t* naig, );

int naig_compile
  (naig_t* naig, char* grammar);

int naig_run
  (
    naig_t* naig,
    unsigned char* input,
    unsigned input_length,
    naig_result_t* result
  );

#endif
