#ifndef _NAIA_TYPES_H_
#define _NAIA_TYPES_H_

typedef struct
{
  char*             assembly;
  naie_result_t*    captures;
  struct {
    unsigned          size;
    struct {
      char*             str;
      unsigned          len;
      unsigned          offset;
    }                 table[ NAIA_LABELS_MAX ];
  }                 labels;
  NAIG_ERR_T      (*write)(void* ptr, unsigned size, void* arg);
  void*             write_arg;
}
naia_t;

#endif
