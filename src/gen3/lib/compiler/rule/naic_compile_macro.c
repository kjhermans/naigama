/**
 * This file is part of Raksaka / NAIG,
 * which is a network guard / message parser solution.
 * Copyright 2020, KJ Hermans
 * Written by KJ Hermans <kees.jan.hermans@gmail.com>
 *
 * LICENSE:
 * Withheld
 *
 * \file
 * \brief
 */

#include "../naic_private.h"

static
NAIG_ERR_T naic_compile_macro_ranges
  (naic_t* naic, naio_resobj_t* macro)
{
  char label[ 64 ];
  char* chr = macro->string + 1;

  snprintf(label, sizeof(label), "__MACRO_%u", ++(naic->labelcount));
  switch (macro->stringlen) {
  case 2:
    switch (*chr) {
    case 's':
      NAIC_WRITE(
        "  catch %s_ALT1\n"
        "  char 0a\n"
        "  commit %s_OUT\n"
        "%s_ALT1:\n"
        "  catch %s_ALT2\n"
        "  char 0d\n"
        "  commit %s_OUT\n"
        "%s_ALT2:\n"
        "  catch %s_ALT3\n"
        "  char 09\n"
        "  commit %s_OUT\n"
        "%s_ALT3:\n"
        "  catch %s_ALT4\n"
        "  char 0b\n"
        "  commit %s_OUT\n"
        "%s_ALT4:\n"
        "  char 20\n"
        "%s_OUT:\n"
        , label
        , label
        , label
        , label
        , label
        , label
        , label
        , label
        , label
        , label
        , label
        , label
        , label
      );
      break;
    case 'w':
      NAIC_WRITE(
        "  catch %s_ALT\n"
        "  range 65 90\n"
        "  commit %s_OUT\n"
        "%s_ALT:\n"
        "  range 97 122\n"
        "%s_OUT:\n"
        , label
        , label
        , label
        , label
      );
      break;
    case 'a':
      NAIC_WRITE(
        "  catch %s_ALT1\n"
        "  range 48 57\n"
        "  commit %s_OUT\n"
        "%s_ALT1:\n"
        "  catch %s_ALT2\n"
        "  range 65 90\n"
        "  commit %s_OUT\n"
        "%s_ALT2:\n"
        "  range 97 122\n"
        "%s_OUT:\n"
        , label
        , label
        , label
        , label
        , label
        , label
        , label
      );
      break;
    case 'n':
      NAIC_WRITE("  range %u %u\n", '0', '9');
      break;
    case 'r':
      NAIC_WRITE("  range 32 126\n");
      return NAIG_OK;
    default:
      snprintf(naic->error, sizeof(naic->error), "Unknown macro '%c'", *chr);
      RETURNERR(NAIG_ERR_MACRO);
    }
    break;
  case '3':
    if (chr[ 0 ] == 'n' && chr[ 1 ] == 'l') {
      NAIC_WRITE(
        "  catch %s_ALT\n"
        "  char 0a\n"
        "  commit %s_OUT\n"
        "%s_ALT:\n"
        "  char 0d\n"
        "%s_OUT:\n"
        , label
        , label
        , label
        , label
      );
    } else {
      snprintf(naic->error, sizeof(naic->error),
        "Unknown macro '%c%c'", chr[0], chr[1]
      );
      RETURNERR(NAIG_ERR_MACRO);
    }
    break;
  default:
    snprintf(naic->error, sizeof(naic->error), "Macro length error.");
    RETURNERR(NAIG_ERR_MACRO);
  }
  return NAIG_OK;
}
  
static
NAIG_ERR_T naic_compile_macro_set
  (naic_t* naic, naio_resobj_t* macro)
{
  unsigned i;
  unsigned char set[ 32 ] = { 0 };
  char* chr = macro->string + 1;

  switch (macro->stringlen) {
  case 2:
    switch (*chr) {
    case 's':
      NAIC_SET_BIT_SET(set, '\n');
      NAIC_SET_BIT_SET(set, '\r');
      NAIC_SET_BIT_SET(set, '\t');
      NAIC_SET_BIT_SET(set, '\v');
      NAIC_SET_BIT_SET(set, ' ');
      break;
    case 'w':
      for (i = 'A'; i <= 'Z'; i++) { NAIC_SET_BIT_SET(set, i); }
      for (i = 'a'; i <= 'z'; i++) { NAIC_SET_BIT_SET(set, i); }
      break;
    case 'a':
      for (i = 'A'; i <= 'Z'; i++) { NAIC_SET_BIT_SET(set, i); }
      for (i = 'a'; i <= 'z'; i++) { NAIC_SET_BIT_SET(set, i); }
      for (i = '0'; i <= '9'; i++) { NAIC_SET_BIT_SET(set, i); }
      break;
    case 'n':
      for (i = '0'; i <= '9'; i++) { NAIC_SET_BIT_SET(set, i); }
      break;
    case 'r':
      for (i = 32; i < 127; i++) { NAIC_SET_BIT_SET(set, i); }
      return NAIG_OK;
    default:
      snprintf(naic->error, sizeof(naic->error), "Unknown macro '%c'", *chr);
      RETURNERR(NAIG_ERR_MACRO);
    }
    break;
  case '3':
    if (chr[ 0 ] == 'n' && chr[ 1 ] == 'l') {
      NAIC_SET_BIT_SET(set, '\n');
      NAIC_SET_BIT_SET(set, '\r');
    } else {
      snprintf(naic->error, sizeof(naic->error),
        "Unknown macro '%c%c'", chr[0], chr[1]
      );
      RETURNERR(NAIG_ERR_MACRO);
    }
    break;
  default:
    snprintf(naic->error, sizeof(naic->error), "Macro length error.");
    RETURNERR(NAIG_ERR_MACRO);
  }
  NAIC_WRITE("  set ");
  for (i=0; i < sizeof(set); i++) {
    NAIC_WRITE("%.2x", set[ i ]);
  }
  NAIC_WRITE("\n");

  return NAIG_OK;
}

/**
 * Processes the hardcorded macroes %s %w %a %n %nl, which stand for
 * whitespace, alphabetic ('word'), alphanumeric, numeric and newline
 * character sets, and compiles them to 'set' instructions.
 */
NAIG_ERR_T naic_compile_macro
  (naic_t* naic, naio_resobj_t* macro)
{
  if (naic->flags & NAIC_FLG_SETSASRANGES) {
    return naic_compile_macro_ranges(naic, macro);
  } else {
    return naic_compile_macro_set(naic, macro);
  }
}
