#ifndef _NAIA_TYPES_H_
#define _NAIA_TYPES_H_

typedef struct naia_namespace naia_namespace_t;

struct naia_namespace
{
  char*              name;
  naio_labelmap_t    labels;
  naia_namespace_t*  parent;
  naia_namespace_t** children;
  unsigned           nchildren;
};

typedef struct
{
  char*             assembly;
  naio_result_t*    captures;
  struct {
    naia_namespace_t* top;
    naia_namespace_t* current;
  }                 namespace;
  naio_buf_t        buffer;
  char              error[ 1024 ];
  NAIG_ERR_T      (*write)(void* ptr, unsigned size, void* arg);
  void*             write_arg;
}
naia_t;

#endif
