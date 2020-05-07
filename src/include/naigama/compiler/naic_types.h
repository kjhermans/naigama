#ifndef _NAIC_TYPES_H_
#define _NAIC_TYPES_H_

typedef struct
{
  unsigned          size;
  struct {
    char              name[ 64 ];
    unsigned          slot;
  }                 table[ NAIC_SLOTMAP_SIZE ];
}
naic_slotmap_t;

typedef struct
{
  char*             grammar;
  naie_result_t*    captures;
  naie_resact_t*    currentrule;
  naic_slotmap_t*   slotmap;
  unsigned          capindex;
  unsigned          labelcount;
  unsigned          counter;
  unsigned          slot;
  unsigned          flags;
  struct {
    uint32_t          tmpvalue;
    unsigned          nbytes;
  }                 quad;
  struct {
    struct {
      char*             key;
      unsigned          keysize;
      unsigned          slot;
    }                 table[ NAIC_RULEVARMAP_SIZE ];
    unsigned          size;
  }                 rulevarmap;
  NAIG_ERR_T      (*write)(void* ptr, char* fmt, ...);
  void*             write_arg;
}
naic_t;

#endif
