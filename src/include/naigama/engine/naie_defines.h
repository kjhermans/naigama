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

#ifndef _NAIG_DEFINES_H_
#define _NAIG_DEFINES_H_

//#include 

#define NAIG_INSTR_LENGTH(instr) ((((instr)>>16)&0xff)+4)

/** Error handling **/

typedef struct
{
  int                                   code;
}
NAIG_ERR_T;

#define NAIG_FAILURE                    ((NAIG_ERR_T){ .code = 1 })
#define NAIG_OK                         ((NAIG_ERR_T){ .code = 0 })

#define NAIG_ERR_READ                   ((NAIG_ERR_T){ .code = -1 })
#define NAIG_ERR_WRITE                  ((NAIG_ERR_T){ .code = -2 })
#define NAIG_ERR_UNIMPL                 ((NAIG_ERR_T){ .code = -3 })
#define NAIG_ERR_NOTFOUND               ((NAIG_ERR_T){ .code = -4 })

#define NAIE_ERR_STACKFULL              ((NAIG_ERR_T){ .code = -17 })
#define NAIE_ERR_STACKEMPTY             ((NAIG_ERR_T){ .code = -18 })
#define NAIE_ERR_STACKCORRUPT           ((NAIG_ERR_T){ .code = -19 })
#define NAIE_ERR_BADOPCODE              ((NAIG_ERR_T){ .code = -20 })
#define NAIE_ERR_CODEOVERFLOW           ((NAIG_ERR_T){ .code = -21 })
#define NAIE_ERR_ACTIONFULL             ((NAIG_ERR_T){ .code = -22 })
#define NAIE_ERR_ACTIONLIST             ((NAIG_ERR_T){ .code = -23 })
#define NAIE_ERR_VARIABLE               ((NAIG_ERR_T){ .code = -24 })
#define NAIE_ERR_LABELMAP               ((NAIG_ERR_T){ .code = -25 })
#define NAIE_ERR_REGFULL                ((NAIG_ERR_T){ .code = -26 })
#define NAIE_ERR_REGNOTFOUND            ((NAIG_ERR_T){ .code = -27 })
#define NAIE_ERR_BITFAULT               ((NAIG_ERR_T){ .code = -28 })
#define NAIE_ERR_TRAP                   ((NAIG_ERR_T){ .code = -29 })

#ifdef TODO
#undef TODO
#endif
#define TODO(str) fprintf(stderr, "TODO: %s\n", str);

#ifdef _DEBUG
#define DEBUG(__e) { \
  fprintf(stderr, "NAIG Error %d at %s:%d\n", __e.code, __FILE__, __LINE__); \
}
#else
#define DEBUG(__e) (void)__e;
#endif

#ifdef RETURNERR
#undef RETURNERR
#endif
#define RETURNERR(__e) { DEBUG(__e) return __e; }

#ifdef CHECK
#undef CHECK
#endif
#define NAIG_CHECK(fnc) { \
  NAIG_ERR_T __e = (fnc); \
  if (__e.code) { \
    DEBUG(__e); \
    return __e; \
  } \
}
#define CHECK NAIG_CHECK

/** Limits **/

#define NAIG_MAX_STACK                  16384
#define NAIG_MAX_ACTIONS                16384
#define NAIG_MAX_LABEL                  128
#define NAIG_MAX_LABELMAP               1024
#define NAIG_MAX_REGISTER               128

/** Macroes **/

#ifdef __unix__
#include <arpa/inet.h>
#else
#define ntohl(x) x
#define htonl(x) x
//extern void LOGME(char* fmt, ...);
//#define fprintf(stderr, ...) LOGME(__VA_ARGS__)
#endif

#ifdef GET_32BIT_NWO
#undef GET_32BIT_NWO
#endif
#define GET_32BIT_NWO(mem,off) ({ uint32_t _vl; memcpy(&_vl,(mem)+(off),4); _vl=ntohl(_vl); _vl; })


#ifdef DATAINSET
#undef DATAINSET
#endif
#define DATAINSET(set,chr) (set[chr/8]&(1<<(chr%8)))


#define NAIG_STACK_CALL                 0x000000a5
#define NAIG_STACK_CATCH                0x00007b00
#define NAIG_STACK_END                  0x00310048

#endif // ~_NAIG_DEFINES_H_
