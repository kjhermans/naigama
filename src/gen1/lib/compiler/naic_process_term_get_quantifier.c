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

#include "naic_private.h"

static
int naic_atoi
  (naic_t* naic, unsigned token)
{
  return atoi_substr(
    naic->grammar,
    naic->captures->actions[ token ].start,
    naic->captures->actions[ token ].length
  );
}

/**
 *
 */
NAIG_ERR_T naic_process_term_get_quantifier
  (naic_t* naic, unsigned end, int quantifier[ 2 ])
{
  unsigned q = 0, i = naic->capindex;

#ifdef _DEBUG
  fprintf(stderr, "-- %s ", __FILE__); naic_debug(naic);
#endif

  while (i < naic->captures->count
         && naic->captures->actions[ i ].start + naic->captures->actions[ i ].length <= end)
  {
    if (naic->captures->actions[ i ].slot == SLOT_ENDOWEDMATCHER_QUANTIFIER
        && naic->captures->actions[ i ].start + naic->captures->actions[ i ].length == end)
    {
      q = i;
    }
    i++;
  }
  if (q) {
    switch (naic->grammar[ naic->captures->actions[ q ].start ]) {
    case '?':
      quantifier[ 0 ] = 0;
      quantifier[ 1 ] = 1;
      return NAIG_OK;
    case '+':
      quantifier[ 0 ] = 1;
      quantifier[ 1 ] = -1;
      return NAIG_OK;
    case '*':
      quantifier[ 0 ] = 0;
      quantifier[ 1 ] = -1;
      return NAIG_OK;
    case '^':
      ++q;
      break;
    default: ; /* error */
    }
    switch (naic->captures->actions[ q ].slot) {
    case SLOT_QUANTIFIER:
      quantifier[ 0 ] = naic_atoi(naic, q);
      quantifier[ 1 ] = naic_atoi(naic, q + 1);
      break;
    case SLOT_QUANTIFIER_2:
      quantifier[ 0 ] = 0;
      quantifier[ 1 ] = naic_atoi(naic, q);
      break;
    case SLOT_QUANTIFIER_3:
      quantifier[ 0 ] = naic_atoi(naic, q);
      quantifier[ 1 ] = -1;
      break;
    case SLOT_QUANTIFIER_4:
      quantifier[ 0 ] = naic_atoi(naic, q);
      quantifier[ 1 ] = quantifier[ 0 ];
      break;
    }
  } else {
    quantifier[ 0 ] = 1;
    quantifier[ 1 ] = 1;
  }
  return NAIG_OK;
}
