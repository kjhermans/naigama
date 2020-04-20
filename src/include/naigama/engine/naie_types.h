/**
 * This file is part of NAIG.
 * Copyright 2019, KJ Hermans
 * Written by KJ Hermans <kees.jan.hermans@gmail.com>
 *
 * LICENSE:
 * Withheld
 *
 * \file
 * \brief
 */

#ifndef _NAIG_TYPES_H_
#define _NAIG_TYPES_H_

#include <stdint.h>

#include "naie_defines.h"

typedef struct
{
  uint32_t reg;
  unsigned stacklen;
  uint32_t value;
}
naie_register_t;

typedef enum
{
  NAIG_STACK_CALL,
  NAIG_STACK_CATCH
}
naie_stackentry_type_t;

typedef struct
{
  naie_stackentry_type_t                type;
  uint32_t                              address;
  unsigned                              input_pos;
  unsigned                              actioncount;
}
naie_stackentry_t;

typedef enum
{
  NAIG_ACTION_OPENCAPTURE = 1,
  NAIG_ACTION_CLOSECAPTURE,
  NAIG_ACTION_REPLACE
}
naie_actiontype_t;

typedef struct
{
  naie_actiontype_t                     action;
  uint32_t                              slot;
  unsigned                              inputpos;
  uint64_t                              intvalue;
  unsigned                              stacklength;
}
naie_action_t;

typedef struct
{
  unsigned char*                        input;
  unsigned                              input_length;
  unsigned                              input_pos;
  unsigned char*                        bytecode;
  unsigned                              bytecode_length;
  unsigned                              bytecode_pos;
  unsigned                              stacksizebeforefail;
  struct {
    naie_stackentry_t                     entries[ NAIG_MAX_STACK ];
    unsigned                              size;
  }                                     stack;
  struct {
    naie_action_t                         entries[ NAIG_MAX_ACTIONS ];
    unsigned                              size;
  }                                     actions;
  unsigned                              noinstructions;
  unsigned                              maxstackdepth;
  int                                   debug;
  int                                   diligent;
  int                                   uselabelmap;
  struct {
    struct {
      uint32_t                              offset;
      char                                  label[ NAIG_MAX_LABEL ];
    }                                     entries[ NAIG_MAX_LABELMAP ];
    unsigned                              size;
  }                                     labelmap;
  naie_register_t                       reg[ NAIG_MAX_REGISTER ];
}
naie_engine_t;

typedef struct {
  uint32_t                              action;
  uint32_t                              slot;
  uint32_t                              start;
  uint32_t                              stop;
}
naie_resact_t;

typedef struct
{
  int                                   code;
  naie_resact_t                         actions[ NAIG_MAX_ACTIONS ];
  unsigned                              size;
}
naie_result_t;

typedef struct
{
  struct {
    char                                  key[ 64 ];
    uint32_t                              offset;
  }                                     table[ 1024 ];
  unsigned                              size;
}
naig_labelmap_t;

#endif
