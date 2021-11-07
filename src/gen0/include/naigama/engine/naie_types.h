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

#ifndef _NAIE_TYPES_H_
#define _NAIE_TYPES_H_

#include <stdint.h>

#include <naigama/naig_types.h>
#include <naigama/naig_defines.h>

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
  uint32_t                              offset;
  char                                  label[ NAIG_MAX_LABEL ];
}
naie_labelentry_t;

typedef struct
{
  unsigned                              input_pos;
  unsigned                              bytecode_pos;
}
naie_loopdetectentry_t;

typedef struct
{
  unsigned                              action;
  uint32_t                              slot;
  unsigned                              inputpos;
  uint64_t                              intvalue;
  unsigned                              stacklength;
}
naie_action_t;

typedef struct naie_engine naie_engine_t;

struct naie_engine
{
  const unsigned char*                  input;
  unsigned                              input_length;
  unsigned                              input_pos;
  const unsigned char*                  bytecode;
  unsigned                              bytecode_length;
  unsigned                              bytecode_pos;
  struct {
    naie_stackentry_t*                    entries;
    unsigned                              count;  // amount used
    unsigned                              length; // amount allocated
    int                                   realloc;
  }                                     stack;
  struct {
    naie_action_t*                        entries;
    unsigned                              count;
    unsigned                              length;
    int                                   realloc;
  }                                     actions;
  struct {
    naie_labelentry_t*                    entries;
    unsigned                              count;
    unsigned                              length;
  }                                     labels;
  struct{
    naie_register_t*                      entries;
    unsigned                              length;
    int                                   realloc;
  }                                     reg;
  struct {
    naie_loopdetectentry_t*               entries;
    unsigned                              count;
    unsigned                              length;
  }                                     loopdetect;
  struct {
    unsigned                              stacksizebeforefail;
    unsigned                              noinstructions;
    unsigned                              maxstackdepth;
  }                                     forensics;
  struct {
    unsigned                              maxnoinstructions;
    unsigned                              maxstackdepth;
  }                                     config;
  unsigned                              flags;
#define NAIE_FLAG_DEBUG                 (1<<0)
#define NAIE_FLAG_DILIGENT              (1<<1)
#define NAIE_FLAG_USELABELMAP           (1<<2)
#define NAIE_FLAG_DOREPLACE             (1<<3)
#define NAIE_FLAG_ENDLESS               (1<<4)
#define NAIE_FLAG_UTF8                  (1<<5)
  NAIG_ERR_T                         (*debugger)(naie_engine_t*,uint32_t,void*);
  void*                                 debugarg;
  unsigned                              debugoffset;
  char*                                 debugtext;
  unsigned                              debugstate;
#define NAIE_DEBUG_FREE                 0
#define NAIE_DEBUG_HALT                 1
#define NAIE_DEBUG_CALL                 2
};

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
  naie_resact_t*                        actions;
  unsigned                              length; // allocated
  unsigned                              count;  // used
}
naie_result_t;

/**
 * Cursor to search the results list as a tree
 */
typedef struct
{
  naie_result_t*                        result;
  unsigned                              index;
}
naie_rescrs_t;

typedef struct naie_resobj naie_resobj_t;

struct naie_resobj
{
  unsigned                              type;
  char*                                 string;
  unsigned                              stringlen;
  unsigned                              origoffset;
  naie_resobj_t**                       children;
  unsigned                              nchildren;
  void*                                 auxptr; /* this one is for you */
};

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
