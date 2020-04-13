#ifndef _NAIA_H_
#define _NAIA_H_

#include <naigama/util/util_functions.h>
#include <naigama/engine/naie.h>

#define NAIA_LABELS_MAX                 2048

#define NAIA_ERR_LABEL                  ((NAIG_ERR_T){ .code = 513 })

typedef struct
{
  char*             assembly;
  naie_result_t*    captures;
  FILE*             output;
  struct {
    unsigned          size;
    struct {
      char*             str;
      unsigned          len;
      unsigned          offset;
    }                 table[ NAIA_LABELS_MAX ];
  }                 labels;
}
naia_t;

#include "naia_functions.h"
#include "generated.h"

#endif
