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

#ifndef _NAIE_DEFINES_H_
#define _NAIE_DEFINES_H_

#define NAIG_INSTR_LENGTH(instr) ((((instr)>>16)&0xff)+4)

/** Limits **/

//#define NAIG_MAX_STACK                  16384
//#define NAIG_MAX_ACTIONS                16384
#define NAIG_MAX_LABEL                  128
//#define NAIG_MAX_LABELMAP               1024
//#define NAIG_MAX_REGISTER               128
//#define NAIE_MAX_LOOPDETECT             256

/** Macroes **/

#ifdef DATAINSET
#undef DATAINSET
#endif
#define DATAINSET(set,chr) (set[chr/8]&(1<<(chr%8)))


#define NAIG_STACK_CALL                 0x000000a5
#define NAIG_STACK_CATCH                0x00007b00
#define NAIG_STACK_END                  0x00310048


#define NAIG_ACTION_OPENCAPTURE         0xe3000001
#define NAIG_ACTION_CLOSECAPTURE        0x6f00d400
#define NAIG_ACTION_DELETE              0x00580025
#define NAIG_ACTION_REPLACE_CHAR        0x01002702
#define NAIG_ACTION_REPLACE_QUAD        0x920f00e7

#define ROUNDUP(bound, number) ((number % bound)?(number + (bound - (number % bound))):(number + (number % bound)))


#endif // ~_NAIG_DEFINES_H_
