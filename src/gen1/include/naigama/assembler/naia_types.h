#ifndef _NAIA_TYPES_H_
#define _NAIA_TYPES_H_

typedef struct
{
  char*             str;
  unsigned          len;
  unsigned          offset;
}
naia_labent_t;

typedef struct
{
  char*             assembly;
  naie_result_t*    captures;
  struct {
    naia_labent_t*    entries;
    unsigned          length; // malloced
    unsigned          count;  // used
  }                 labels;
  NAIG_ERR_T      (*write)(void* ptr, unsigned size, void* arg);
  void*             write_arg;
}
naia_t;

#endif
