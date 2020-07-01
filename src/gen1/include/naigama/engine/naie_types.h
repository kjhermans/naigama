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

#ifndef _NAIE_TYPES_H_
#define _NAIE_TYPES_H_

#include <stdint.h>

typedef struct
{
  uint32_t reg;
  unsigned stacklen;
  uint32_t value;
}
naie_register_t;

typedef struct
{
  uint32_t                              type;
  uint32_t                              address;
  unsigned                              input_pos;
  unsigned                              actioncount;
}
naie_stackentry_t;

typedef struct
{
  unsigned                              action;
  uint32_t                              slot;
  unsigned                              inputpos;
  uint64_t                              intvalue;
  unsigned                              stacklength;
}
naie_action_t;

typedef struct
{
  const unsigned char*                  input;
  unsigned                              input_length;
  unsigned                              input_pos;
  const unsigned char*                  bytecode;
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
  unsigned                              flags;
#define NAIE_FLAG_DEBUG                 (1<<0)
#define NAIE_FLAG_DILIGENT              (1<<1)
#define NAIE_FLAG_USELABELMAP           (1<<2)
#define NAIE_FLAG_DOREPLACE             (1<<3)
#define NAIE_FLAG_ENDLESS               (1<<4)
#define NAIE_FLAG_UTF8                  (1<<5)
  struct {
    struct {
      uint32_t                              offset;
      char                                  label[ NAIG_MAX_LABEL ];
    }                                     entries[ NAIG_MAX_LABELMAP ];
    unsigned                              size;
  }                                     labelmap;
  naie_register_t                       reg[ NAIG_MAX_REGISTER ];
  struct {
    struct {
      unsigned                              input_pos;
      unsigned                              bytecode_pos;
    }                                     entries[ NAIE_MAX_LOOPDETECT ];
    unsigned                              size;
  }                                     loopdetect;
}
naie_engine_t;

typedef struct {
  uint32_t                              action;
  uint32_t                              slot;
  uint32_t                              start;
  uint32_t                              length; // dubs as char/quad in replace
}
naie_resact_t;

typedef struct
{
  int                                   code;
  naie_resact_t                         actions[ NAIG_MAX_ACTIONS ];
  unsigned                              size;
}
naie_result_t;

/**
 * Cursor to search the results list as a tree
 */
typedef struct
{
  naie_result_t*                        result;
  unsigned                              parent_scope_begin;
  unsigned                              parent_scope_end;
  unsigned                              scope_begin;
  unsigned                              scope_end;
}
naie_rescrs_t;

typedef struct
{
  struct {
    char                                  key[ 64 ];
    uint32_t                              offset;
  }                                     table[ 1024 ];
  unsigned                              size;
}
naig_labelmap_t;

typedef NAIG_ERR_T(*naie_capture_t)
                  (const unsigned char*,unsigned,unsigned,void*);
typedef NAIG_ERR_T(*naie_delete_t)
                  (const unsigned char*,unsigned,unsigned,void*);
typedef NAIG_ERR_T(*naie_insert_t)
                  (const unsigned char*,unsigned,unsigned,uint32_t,void*);

#endif
