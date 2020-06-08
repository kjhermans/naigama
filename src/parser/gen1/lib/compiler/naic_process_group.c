#include "naic_private.h"
  
NAIG_ERR_T naic_process_group
  (naic_t* naic)
{
#ifdef _DEBUG
  fprintf(stderr, "-- %s ", __FILE__); naic_debug(naic);
#endif

  ++(naic->capindex);
  CHECK(naic_process_expression(naic));
  return NAIG_OK;
}
