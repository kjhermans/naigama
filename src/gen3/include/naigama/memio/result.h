/**
 * This file is part of Oroszlan, a parsing and scripting environment

Copyright (c) 2020, Kees-Jan Hermans <kees.jan.hermans@gmail.com>
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the organization nor the
      names of its contributors may be used to endnaio or promote products
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

#ifndef _NAIO_RESULT_H_
#define _NAIO_RESULT_H_

typedef struct {
  uint32_t                              action;
  uint32_t                              slot;
  uint32_t                              start;
  uint32_t                              length; // dubs as char/quad in replace
}
naio_resact_t;

typedef struct
{
  int                                   code;
  naio_resact_t*                        actions;
  unsigned                              length; // allocated
  unsigned                              count;  // used
}
naio_result_t;

typedef struct naio_resobj naio_resobj_t;

struct naio_resobj
{
  unsigned                              type;
  char*                                 string;
  unsigned                              stringlen;
  unsigned                              origoffset;
  naio_resobj_t*                        parent;
  naio_resobj_t**                       children;
  unsigned                              nchildren;
  unsigned                              slotnumber;
  void*                                 auxptr; /* this one is for you */
};

#define naio_resobj_debug naio_result_object_debug
#define naio_resobj_query naio_result_object_query
#define naio_resobj_iter  naio_result_object_iterate

typedef struct
{
  unsigned                              flags;
#define NAIO_RESOBJ_FLAG_SLOT           (1<<0)
#define NAIO_RESOBJ_FLAG_RELINDEX       (1<<1)
#define NAIO_RESOBJ_FLAG_ABSINDEX       (1<<2)
#define NAIO_RESOBJ_FLAG_STRING         (1<<3)
#define NAIO_RESOBJ_FLAG_MEM            (1<<4)
#define NAIO_RESOBJ_FLAG_UPONSUCCESS    (1<<5)
  struct {
    unsigned                              slot;
    unsigned                              relindex;
    unsigned                              absindex;
    char*                                 string;
    struct {
      void*                                 ptr;
      unsigned                              size;
    }                                     mem;
  }                                     query;
  naio_resobj_t*                        object;
  unsigned                              uponsuccess;
}
naio_resobj_itelt_t;

#endif
