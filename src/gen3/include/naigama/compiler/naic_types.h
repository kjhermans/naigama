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
#define NAIC_NSPTYPE_VAR                2
#define NAIC_NSPTYPE_FUNCTION           3
#define NAIC_NSPTYPE_CODEVAR            4
  unsigned          type;
  union {
    struct {
      int               defined;
    }                 rule;
    struct {
      unsigned          slot;
    }                 variable;
    struct {
      struct {
        char*             type;
        char*             name;
      }                 params[ 64 ];
      unsigned          paramcount;
    }                 function;
    struct {
      char*             subtype;
      unsigned          reg;
    }                 codevar;
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

typedef struct naic_scope naic_scope_t;

struct naic_scope
{
  naic_scope_t*     up;
  naic_nsp_t        nsp;
};

typedef struct
{
  char*             grammar;
  naic_slotmap_t*   slotmap;
  unsigned          labelcount;
  unsigned          counter;
  unsigned          slot;
  unsigned          flags;
/*
  struct {
    uint32_t          tmpvalue;
    unsigned          nbytes;
  }                 quad;
*/
  naic_nsp_t        nsp;
  naic_scope_t      globalscope;
  naic_scope_t*     currentscope;
  NAIG_ERR_T      (*write)(void* ptr, char* fmt, ...);
  void*             write_arg;
  char              error[ 256 ];
  struct {
    char*             string;
    unsigned          fill;
    unsigned          size;
  }                 postfix;
}
naic_t;

#endif
