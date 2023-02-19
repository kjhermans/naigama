#ifndef _NAIGAMA_H_
#define _MAIGAMA_H_

#include "release.h"
#include "naig_defines.h"
#include "naigama_types.h"
#include "naig_types.h"
#include "naig_error.h"

#include <naigama/memio/result.h>

int naig_init_malloc
  (naig_t* naig);

int naig_init_mem
  (naig_t* naig, void* mem, unsigned size);

NAIG_ERR_T naig_compile
  (naig_t* naig, char* grammar, int traps);

NAIG_ERR_T naig_run
  (
    naig_t* naig,
    unsigned char* input,
    unsigned input_length,
    naio_result_t* result
  );

char* naig_error
  (NAIG_ERR_T e);

char* naig_error_explicit
  (NAIG_ERR_T e);

#include "generation.h"

#include <naigama/compiler/naic.h>
#include <naigama/assembler/naia.h>
#include <naigama/engine/naie.h>

#endif
