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
  unsigned          capindex;
  FILE*             output;
  naic_slotmap_t*   slotmap;
  unsigned          labelcount;
  unsigned          counter;
  unsigned          slot;
  unsigned          flags;
  struct {
    struct {
      char*             key;
      unsigned          keysize;
      unsigned          slot;
    }                 table[ NAIC_RULEVARMAP_SIZE ];
    unsigned          size;
  }                 rulevarmap;
}
naic_t;

#endif
