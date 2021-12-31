#ifndef _NAIA_TYPES_H_
#define _NAIA_TYPES_H_

typedef struct
{
  char*             assembly;
  naio_result_t*    captures;
  naio_labelmap_t   labels;
  naio_buf_t        buffer;
  NAIG_ERR_T      (*write)(void* ptr, unsigned size, void* arg);
  void*             write_arg;
}
naia_t;

#endif
