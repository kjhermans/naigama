#ifndef _NAIC_TYPES_H_
#define _NAIC_TYPES_H_

#include <naigama/naig_types.h>
#include <naigama/engine/naie_types.h>
#include "naic_defines.h"

typedef struct
{
  unsigned          length; // malloced
  unsigned          count;  // used
  struct {
    char              name[ 64 ];
    unsigned          slot;
  }*                table;
}
naic_slotmap_t;

typedef struct
{
  char*             key;
#define NAIC_NSPTYPE_RULE               1
#define NAIC_NSPTYPE_FUNCTION           2
  unsigned          type;
  union {
    struct {
      int               defined;
    }                 rule;
    struct {
      struct {
        char*             type;
        char*             name;
      }                 params[ 64 ];
      unsigned          paramcount;
    }                 function;
  }                 value;
}
naic_nspent_t;

typedef struct
{
  char*             key;
  int               type;
}
naic_refent_t;

typedef struct
{
  naic_nspent_t*    entries;
  unsigned          length; // malloced
  unsigned          count;  // used
}
naic_nsp_t;

typedef struct
{
  naic_refent_t*    entries;
  unsigned          length; // malloced
  unsigned          count;  // used
}
naic_ref_t;

typedef struct
{
  char*             grammar;
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
  naic_nsp_t        nsp;
  naic_ref_t        references;
  NAIG_ERR_T      (*write)(void* ptr, char* fmt, ...);
  void*             write_arg;
  char              error[ 256 ];
}
naic_t;

#endif
