#ifndef _LIST_H_
#define _LIST_H_

typedef struct
{
  void* mem;
  unsigned size;
  unsigned nelts;
  unsigned flags;
#define LIST_FLAG_STATIC                (1<<0)
}
list_t;

#define LIST_PUT(list, type, elt) { \
  if ((list->nelts + 1) * sizeof(type) > list->size) { \
    if (list->flags & LIST_FLAG_STATIC) { \
      LIST_ERROR_PUT \
    } else { \
      unsigned newsize = (list->nelts + 32) * sizeof(type); \
      list->mem = realloc(list->mem, newsize); \
      if (list->mem == NULL) { \
        LIST_ERROR_PUT \
      } \
      list->size = newsize; \
    } \
  } \
  memcpy(list->mem + (list->nelts * sizeof(type)), elt, sizeof(type)); \
  ++(list->nelts); \
}

#define LIST_GET(list, type, index) ({ \
  type result; \
  if (index < list->nelts) { \
    memcpy(&result, list->mem + (index * sizeof(type)), sizeof(type); \
  } else { \
    LIST_ERROR_GET \
  } \
  result; \
}}

#define LIST_DEL(list, type, index) { \
}

#endif
