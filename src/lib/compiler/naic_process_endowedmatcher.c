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

/**
 *
 */
NAIG_ERR_T naic_process_endowedmatcher
  (naic_t* naic)
{
  char l1[ 64 ];
  char l2[ 64 ];
  char l3[ 64 ];
  char l4[ 64 ];
  char l5[ 64 ];
  char l6[ 64 ];
  char notand = 0;
  int quantifier[ 2 ] = { 1, 1 };
  naic_t copy;
  unsigned i, end;

#ifdef _DEBUG
  fprintf(stderr, "-- %s ", __FILE__); naic_debug(naic);
#endif

  if (naic->captures->actions[ naic->capindex ].slot == SLOT_TERM_ENDOWEDMATCHER) {
    end = naic->captures->actions[ naic->capindex ].start +
          naic->captures->actions[ naic->capindex ].length;
    ++(naic->capindex);
  } else {
    //.. return error
  }

  snprintf(l1, sizeof(l1), "__TERM_%u", (naic->labelcount)++);
  snprintf(l2, sizeof(l2), "__TERM_%u", (naic->labelcount)++);
  snprintf(l3, sizeof(l3), "__TERM_%u", (naic->labelcount)++);
  snprintf(l4, sizeof(l4), "__TERM_%u", (naic->labelcount)++);
  snprintf(l5, sizeof(l5), "__TERM_%u", (naic->labelcount)++);
  snprintf(l6, sizeof(l6), "__TERM_%u", (naic->labelcount)++);

  if (naic->captures->actions[ naic->capindex ].slot == SLOT_ENDOWEDMATCHER_NOTAND) {
    notand= naic->grammar[ naic->captures->actions[ naic->capindex ].start ];
    if (notand == '!' || notand == '&') {
      CHECK(naic->write(naic->write_arg, "  catch %s\n", l1));
    }
    ++(naic->capindex);
  }

  CHECK(naic_process_term_get_quantifier(naic, end, quantifier));

  copy = *naic;
  if (quantifier[ 0 ] == 1) {
    CHECK(naic_process_matcher(&copy));
  } else if (quantifier[ 0 ] > 1) {
    unsigned ctr = (naic->counter)++;
    CHECK(naic->write(naic->write_arg,
                          "  counter %u %u\n"
                          "%s:\n"
                          , ctr
                          , quantifier[ 0 ]
                          , l3
    ));
    CHECK(naic_process_matcher(&copy));
    CHECK(naic->write(naic->write_arg,
                          "  condjump %u %s\n"
                          , ctr
                          , l3
    ));
  }
  naic->labelcount = copy.labelcount;
  naic->rulevarmap = copy.rulevarmap;
  if (quantifier[ 1 ] == -1) {
    CHECK(naic->write(naic->write_arg,
                          "  catch %s\n"
                          "%s:\n"
                          , l5
                          , l4
    ));
    CHECK(naic_process_matcher(naic));
    CHECK(naic->write(naic->write_arg,
                          "  partialcommit %s\n"
                          "%s:\n"
                          , l4
                          , l5
    ));
  } else if (quantifier[ 1 ] > quantifier[ 0 ]) {
    unsigned diff = quantifier[ 1 ] - quantifier[ 0 ];
    if (diff > 1) {
      unsigned ctr = (naic->counter)++;
      CHECK(naic->write(naic->write_arg,
                            "  catch %s\n"
                            "  counter %u %u\n"
                            "%s:\n"
                            , l4
                            , ctr
                            , diff
                            , l5
      ));
      CHECK(naic_process_matcher(naic));
      CHECK(naic->write(naic->write_arg,
                            "  partialcommit %s\n"
                            "%s:\n"
                            "  condjump %u %s\n"
                            "  commit %s\n"
                            "%s:\n"
                            , l6
                            , l6
                            , ctr
                            , l5
                            , l4
                            , l4
      ));
    } else {
      CHECK(naic->write(naic->write_arg,
                            "  catch %s\n"
                            , l4
      ));
      CHECK(naic_process_matcher(naic));
      CHECK(naic->write(naic->write_arg,
//                            "  partialcommit %s\n"
//                            "%s:\n"
                            "  commit %s\n"
                            "%s:\n"
//                            , l5
//                            , l5
                            , l4
                            , l4
      ));
    }
  } else if (quantifier[ 1 ] != quantifier[ 0 ]) {
    RETURNERR(NAIC_ERR_QUANTIFIER);
  }
  if (notand == '!') {
    CHECK(naic->write(naic->write_arg,
                          "  failtwice\n"
                          "%s:\n"
                          , l1
    ));
  } else if (notand == '&') {
    CHECK(naic->write(naic->write_arg,
                          "  backcommit %s\n"
                          "%s:\n"
                          "  fail\n"
                          "%s:\n"
                          , l2
                          , l1
                          , l2
    ));
  }
  for (i = naic->capindex; i < naic->captures->size; i++) {
    if (naic->captures->actions[ i ].start >= end) {
      break;
    }
  }
  naic->capindex = i;
  if (copy.slot > naic->slot) { naic->slot = copy.slot; }
  return NAIG_OK;
}