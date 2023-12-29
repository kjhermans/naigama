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

#ifndef _NAIG_DEFINES_H_
#define _NAIG_DEFINES_H_

//#define OPCODE_TRAP                     0xffffffff

#define NAIGE_NOTFOUND                  -4

/** Error handling **/

//#define NAIG_FAILURE                    ((NAIG_ERR_T){ .code = 1 })
#define NAIG_OK                         ((NAIG_ERR_T){ .code = 0 })

#define NAIG_ISOK(fnc) ({ NAIG_ERR_T __e = (fnc); __e.code == 0; })

/** Limits **/

#define NAIG_MAX_STACK                  16384
#define NAIG_MAX_ACTIONS                16384
#define NAIG_MAX_LABEL                  128
#define NAIG_MAX_LABELMAP               1024
#define NAIG_MAX_REGISTER               128
#define NAIE_MAX_LOOPDETECT             256

/** Macroes **/

#ifdef __unix__
#include <arpa/inet.h>
#else
#define ntohl(x) x
#define htonl(x) x
#endif


#define GET_32BIT_VALUE(mem,off) \
({ \
  const unsigned char* _mem = mem; \
  uint32_t _vl = \
    (_mem[ off   ] << 24) | \
    (_mem[ off+1 ] << 16) | \
    (_mem[ off+2 ] << 8) | \
     _mem[ off+3 ]; \
  _vl; \
})

#define SET_32BIT_VALUE(val) \
({ \
  uint32_t _vl, _og = val; \
  unsigned char* _mem = (unsigned char*)(&_vl); \
  _mem[ 0 ] = ( _og >>24 ) & 0xff; \
  _mem[ 1 ] = ( _og >>16 ) & 0xff; \
  _mem[ 2 ] = ( _og >>8 ) & 0xff; \
  _mem[ 3 ] = _og & 0xff; \
  _vl; \
})


#ifdef GET_32BIT_NWO
#undef GET_32BIT_NWO
#endif
#define GET_32BIT_NWO(mem,off) ({ uint32_t _vl; memcpy(&_vl,(mem)+(off),4); _vl=ntohl(_vl); _vl; })

#ifdef SET_32BIT_NWO
#undef SET_32BIT_NWO
#endif
#define SET_32BIT_NWO(mem,off,val) { uint32_t _vl = htonl(val); memcpy(((char*)mem) + off, &_vl, 4); }

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

#define NAIG_INTRPCAPTURE_RUINT32       1

#define NAIG_SLOT_DEFAULT               0x7fffff

#define NAIG_CHECK(fnc) { \
  NAIG_ERR_T __e = (fnc); \
  if (__e.code) { \
    DEBUG(__e); \
    return __e; \
  } \
}

#define NAIG_CHECK_LOG(fnc, ...) { \
  NAIG_ERR_T __e = (fnc); \
  if (__e.code) { \
    fprintf(stderr, __VA_ARGS__); \
    DEBUG(__e); \
    return __e; \
  } \
}
#ifdef CHECK_LOG
#undef CHECK_LOG
#endif
#define CHECK_LOG NAIG_CHECK_LOG

#define NAIG_CHECK_AND(fnc, alt) { \
  NAIG_ERR_T __e = (fnc); \
  if (__e.code) { \
    (alt); \
    DEBUG(__e); \
    return __e; \
  } \
}

#define NAIG_CHECK_ALT(fnc, alt) { \
  NAIG_ERR_T __e = (fnc); \
  if (__e.code) { \
    return(alt); \
  } \
}

#define NAIG_CHECK_NODEBUG(fnc) { \
  NAIG_ERR_T __e = (fnc); \
  if (__e.code) { \
    return __e; \
  } \
}

#define NAIG_CATCH(fnc,err) { \
  NAIG_ERR_T __e = (fnc); \
  if (__e.code && __e.code != err.code) { \
    DEBUG(__e); \
    return __e; \
  } \
}

#define NAIG_CATCHOUT(fnc,err) { \
  NAIG_ERR_T __e = (fnc); \
  if (__e.code) { \
    if (__e.code == err.code) { \
      return NAIG_OK; \
    } else { \
      DEBUG(__e); \
      return __e; \
    } \
  } \
}

#define NAIG_CATCHALL(fnc) { \
  NAIG_ERR_T __e = (fnc); \
  (void)__e; \
}

#endif // ~_NAIG_DEFINES_H_
