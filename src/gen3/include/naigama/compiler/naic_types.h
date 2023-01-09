#ifndef _NAIC_TYPES_H_
#define _NAIC_TYPES_H_

#include <naigama/naig_types.h>
#include <naigama/engine/naie_types.h>
#include <naigama/memio/naio.h>

#include "naic_defines.h"

#include "naic_parser_types.h"

typedef struct
{
  char*             key;
  int               type;
}
naic_refent_t;

typedef struct
{
  naic_refent_t*    entries;
  unsigned          length; // malloced
  unsigned          count;  // used
}
naic_ref_t;

#include <naigama/array.h>
MAKE_ARRAY_HEADER(unsigned, ulist_)

#include <naigama/map.h>
MAKE_MAP_HEADER(unsigned, ulist_t, ulist_map_)

typedef struct
{
  char*             grammar;
  naio_slotmap_t*   slotmap;
  unsigned          labelcount;
  unsigned          counter;
  unsigned          slot;
  unsigned          flags;
  naic_nspnod_t*    globalscope;
  naic_nspnod_t*    currentscope;
//  naic_nspnod_t*    currentfunction;
  NAIG_ERR_T      (*write)(void* ptr, char* fmt, ...);
  void*             write_arg;
  naio_buf_t        write_buffer;
  naio_buf_t*       current_buffer;
  naio_buf_t        global_buffer;
  ulist_t           capturestack;
  ulist_map_t       capturetree;
  char              error[ 256 ];
#define NAIG_IMPORTRECURSION_MAX 256
  unsigned          importrecursion;
  struct {
    char*             string;
    unsigned          fill;
    unsigned          size;
  }                 postfix;
  struct {
    char**            string;
    unsigned          length;
  }                 paths;
/*
  struct {
    unsigned          variablecount;
    unsigned          functioncount;
  }                 global;
*/
  int               prefix;
  char*             first;
#define             NAIC_FIRST_RULE             1
#define             NAIC_FIRST_FUNCTION         2
#define             NAIC_FIRST_MAINRULE         3
#define             NAIC_FIRST_MAINFUNCTION     4
#define             NAIC_FIRST_IMPLICITRULE     5
  int               firsttype;
}
naic_t;

#endif
