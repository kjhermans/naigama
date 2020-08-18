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
DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
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

#ifndef _NAIP_H_
#define _NAIP_H_

#include <naigama/naigama.h>

#define NAIP_ERR_SYSTEM         ((NAIG_ERR_T){ .code = -257 })
#define NAIP_ERR_TYPE           ((NAIG_ERR_T){ .code = -258 })
#define NAIP_ERR_OPERATION      ((NAIG_ERR_T){ .code = -259 })

typedef struct
{
  uint8_t                       type;
#define NAIP_TYPE_NULL                  0
#define NAIP_TYPE_BOOLEAN               1
#define NAIP_TYPE_INT                   2
#define NAIP_TYPE_FLOAT                 3
#define NAIP_TYPE_STRING                4
  uint8_t                       flags;
  uint16_t                      refcount;
  union {
    struct {
      char*                         ptr;
      unsigned                      siz;
    }                             _str;
    double                        _flt;
    int64_t                       _int;
  }                             value;
}
naip_stent_t;

typedef struct
{
  unsigned char*                bytecode;
  unsigned                      bytecode_length;
  unsigned                      bytecode_offset;
  naip_stent_t                  stack[ 1024 ];
  unsigned                      stack_size;
}
naip_t;

#include <naigama/processor/naip_functions.h>

#endif
