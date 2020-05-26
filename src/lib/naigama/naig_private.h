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

#endif
