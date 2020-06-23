/**
 * This file is part of Naigama, a parser engine.
 * Copyright 2020, KJ Hermans
 * Written by KJ Hermans <kees.jan.hermans@gmail.com>
 *
 * LICENSE:
 * Withheld
 *
 * \file
 * \brief
 */

#ifndef _NAIG_PRIVATE_H_
#define _NAIG_PRIVATE_H_

#include <stdlib.h>
#include <string.h>
#include <stdarg.h>

#include <naigama/naigama.h>

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

#endif
