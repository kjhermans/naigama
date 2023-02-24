/**
 * This file is part of Oroszlan, a parsing and scripting environment

Copyright (c) 2023, Kees-Jan Hermans <kees.jan.hermans@gmail.com>
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

#ifndef _NAIG_GEN4_TD_H_
#define _NAIG_GEN4_TD_H_

typedef struct
{
  unsigned char* data;
  unsigned size;
}
tdt_t;

void td_printf
  (tdt_t* out, char* fmt, ...);

void td_append
  (tdt_t* out, void* mem, unsigned size);

void td_appendchr
  (tdt_t* out, unsigned char c);

void td_appendstr
  (tdt_t* out, char* str);

void td_prepend
  (tdt_t* out, void* mem, unsigned size);

void td_insert
  (tdt_t* out, int offset, void* mem, unsigned size);

void td_reserve
  (tdt_t* out, int offset, unsigned size);

void td_copy
  (tdt_t* out, tdt_t* in);

void td_shift
  (tdt_t* out, unsigned offset, unsigned whereto, int size);

#endif // defined _NAIG_GEN4_TD_H_ ?
