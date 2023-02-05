/**
 * This file is part of Oroszlan, a parsing and scripting environment

Copyright (c) 2021, Kees-Jan Hermans <kees.jan.hermans@gmail.com>
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

#ifndef _NAIC_PARSER_TYPES_H_
#define _NAIC_PARSER_TYPES_H_

#include <naigama/engine/naie_types.h>
#include <naigama/memio/result.h>

typedef struct naic_nspnod naic_nspnod_t;

typedef struct
{
  char*                                 name;
  char*                                 type;
}
naic_param_t;

struct naic_nspnod
{
  char*                                 name;
  unsigned                              id;
  unsigned                              type;
#define NAIC_NSPTYPE_RULE               1
#define NAIC_NSPTYPE_RULEVAR            2
#define NAIC_NSPTYPE_FUNCTION           3
#define NAIC_NSPTYPE_BLOCK              4
#define NAIC_NSPTYPE_CODEGLOBAL         5
#define NAIC_NSPTYPE_CODEVAR            6
#define NAIC_NSPTYPE_FILE               7
  naio_resobj_t*                        parserobject;
  naic_nspnod_t*                        parent;
  unsigned                              scopelabel;
  struct {
    naic_nspnod_t**                       list;
    unsigned                              count;
  }                                     children;
  union {
    struct {
      unsigned                              slot;
    }                                     rulevar;
    struct {
      struct {
        naic_param_t*                         list;
        unsigned                              count;
      }                                     params;
      unsigned                              index;
      unsigned                              maxvars;
    }                                     function;
    struct {
      int                                   reg;
      char*                                 type;
    }                                     codevar;
  }                                     value;
};

#endif
