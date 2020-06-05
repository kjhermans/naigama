#ifndef _LIST_H_
#define _LIST_H_

/**
 * Library to provide arbitrary, self-reallocing list of types
 * using only macroes.
 *
 * Example use:

  LIST_TYPE mylist = LIST_INITIALIZER;
  LIST_PUT(mylist,int,0,3);
  LIST_PUSH(mylist,int,4);
  unsigned size, i = LIST_SIZE(mylist);
  for (i=0; i < size; i++) {
    fprintf(stdout, "Item %u: %d\n", i, LIST_GET(list,int,i));
  }

 *
 */

#define LIST_TYPE void*

#define LIST_INITIALIZER NULL

#define LIST_SIZE(list) ({ \
  unsigned result = 0; if (list) { \
    unsigned header[ 2 ] = list; \
    result = header[ 0 ]; \
  } \
  result; \
})

#define LIST_GET(list,type,index) (type*)({ \
  type* result; \
  unsigned header[ 2 ] = list; \
  if (list == NULL || index < 0 || index > header[ 0 ]) { result = NULL; } \
  else { result = &(((type*)(list+sizeof(header)))[index]); } \
  result; \
})

#define LIST_PUT(list,type,index,elt)

#endif
