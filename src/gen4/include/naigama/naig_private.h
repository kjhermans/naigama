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

#ifndef _NAIGAMA_PRIVATE_H_
#define _NAIGAMA_PRIVATE_H_

#include <stdlib.h>
#include <string.h>
#include <stdarg.h>

#ifdef TODO
#undef TODO
#endif
#define TODO(__str) \
  fprintf(stderr, "TODO: %s in %s:%d\n", __str, __FILE__, __LINE__)

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

#define NAIG_CHECK(fnc) { \
  NAIG_ERR_T __e = (fnc); \
  if (__e.code) { \
    DEBUG(__e); \
    return __e; \
  } \
}
#ifdef CHECK
#undef CHECK
#endif
#define CHECK NAIG_CHECK

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

#define NAIG_CHECK_NODEBUG(fnc) { \
  NAIG_ERR_T __e = (fnc); \
  if (__e.code) { \
    return __e; \
  } \
}
#ifdef CHECK_NODEBUG
#undef CHECK_NODEBUG
#endif
#define CHECK_NODEBUG NAIG_CHECK_NODEBUG

#define NAIG_CATCH(fnc,err) { \
  NAIG_ERR_T __e = (fnc); \
  if (__e.code && __e.code != err.code) { \
    DEBUG(__e); \
    return __e; \
  } \
}
#ifdef CATCH
#undef CATCH
#endif
#define CATCH NAIG_CATCH

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
#ifdef CATCHOUT
#undef CATCHOUT
#endif
#define CATCHOUT NAIG_CATCHOUT

#define NAIG_CATCHALL(fnc) { \
  NAIG_ERR_T __e = (fnc); \
  (void)__e; \
}
#ifdef CATCHALL
#undef CATCHALL
#endif
#define CATCHALL NAIG_CATCHALL

#define NEW(_typ) (_typ*)calloc(1,sizeof(_typ))

#ifdef _DEBUG
#define ASSERT(_exp) { if (!(_exp)) { fprintf(stderr, "Assertion failed in %s:%u\n", __FILE__, __LINE__); abort(); } }
#else
#define ASSERT(_exp)
#endif

#ifdef _DEBUG
#define DBGLOG(fmt, ...) fprintf(stderr, "%s:%d:" fmt, __FILE__, __LINE__, __VA_ARGS__);
#else
#define DBGLOG(fmt, ...)
#endif

#endif
