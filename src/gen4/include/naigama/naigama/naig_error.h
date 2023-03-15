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

#ifndef _NAIG_GEN4_ERROR_H_
#define _NAIG_GEN4_ERROR_H_

typedef struct { int code; char* message; } NAIG_ERR_T;

#define NAIG_IS_OK(e)           (e.code == 0)
#define NAIG_OK                 (NAIG_ERR_T){ .code = 0, .message = 0 }

// Fatal errors

#define NAIG_ERR_IS_FATAL(e)    (e.code < 0)
#define NAIG_ERR_MEM            (NAIG_ERR_T){ .code = -1, .message = 0 }
#define NAIG_ERR_INTEGRITY      (NAIG_ERR_T){ .code = -2, .message = 0 }

// Non fatal errors

#define NAIG_ERR_NOMATCH        (NAIG_ERR_T){ .code =  1, .message = 0 }
#define NAIG_ERR_NOTFOUND       (NAIG_ERR_T){ .code =  2, .message = 0 }
#define NAIG_ERR_OVERFLOW       (NAIG_ERR_T){ .code =  3, .message = 0 }
#define NAIG_ERR_PARSER         (NAIG_ERR_T){ .code =  4, .message = 0 }
#define NAIG_ERR_BYTECODE       (NAIG_ERR_T){ .code =  5, .message = 0 }
#define NAIG_ERR_NAMESPACE      (NAIG_ERR_T){ .code =  6, .message = 0 }
#define NAIG_ERR_QUANTIFIER     (NAIG_ERR_T){ .code =  7, .message = 0 }
#define NAIG_ERR_ESCAPE         (NAIG_ERR_T){ .code =  8, .message = 0 }
#define NAIG_ERR_SINGLE         (NAIG_ERR_T){ .code =  9, .message = 0 }
#define NAIG_ERR_REFERENCE      (NAIG_ERR_T){ .code = 10, .message = 0 }
#define NAIG_ERR_INTRPCAPTURE   (NAIG_ERR_T){ .code = 11, .message = 0 }
#define NAIG_ERR_REPLACE        (NAIG_ERR_T){ .code = 12, .message = 0 }
#define NAIG_ERR_LIMITEDCALL    (NAIG_ERR_T){ .code = 13, .message = 0 }
#define NAIG_ERR_LABEL          (NAIG_ERR_T){ .code = 14, .message = 0 }
#define NAIG_ERR_IO             (NAIG_ERR_T){ .code = 15, .message = 0 }

// Macroes to deal with errors

#ifdef _DEBUG
#define DEBUGMSG(fmt, ...) { fprintf(stderr, fmt, __VA_ARGS__); }
#else
#define DEBUGMSG(fmt, ...)
#endif

#define NAIG_CHECK(fnc,alt) { \
  NAIG_ERR_T __e = (fnc); \
  if (__e.code) { \
    DEBUGMSG("Error code %d at %s:%d\n", __e.code, __FILE__, __LINE__); \
    if (NAIG_ERR_IS_FATAL(__e)) { \
      return __e; \
    } else { \
      (alt); \
    } \
  } \
}

#define PROPAGATE { return __e; }
#define PROPAGATE_WITH_ERROR(__s, ...) { td_printf(&(naic->errorstr), __s "\n", __VA_ARGS__); return __e; }

#define RETURNERR(__e) { \
  DEBUGMSG("Error code %d at %s:%d\n", __e.code, __FILE__, __LINE__); \
  return __e; \
}

#ifdef _DEBUG
#define ASSERT(cnd) { if (!(cnd)) { fprintf(stderr, "Assertion '%s' failed at %s:%d\n", #cnd, __FILE__, __LINE__); }}
#else
#define ASSERT(cnd)
#endif

#ifdef _DEBUG
#define TODO(str) fprintf(stderr, "TODO: %s at %s:%d\n", str, __FILE__, __LINE__);
#else
#define TODO(str)
#endif

#ifdef _DEBUG
#define DEBUGFUNCTION fprintf(stderr, "Function '%s'\n", __PRETTY_FUNCTION__);
#else
#define DEBUGFUNCTION
#endif

#endif // defined _NAIG_GEN4_ERROR_H_ ?
