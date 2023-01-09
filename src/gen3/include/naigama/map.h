#ifndef _TYPED_MAP_H_
#define _TYPED_MAP_H_

#include <stdlib.h>

/**
 * Define MAP_EQUALS if you have, for example, strings.
 */

#ifndef MAP_EQUALS
#define MAP_EQUALS(a,b) (a == b)
#endif

#define COMBINE(a, b) a##b

#define MAKE_MAP_HEADER(Tk, Tv, prefix)                                     \
  typedef struct {                                                          \
    Tk* keys;                                                               \
    Tv* values;                                                             \
    unsigned count;                                                         \
    unsigned allocated;                                                     \
  } COMBINE(prefix, t);                                                     \
  void COMBINE(prefix, init)(COMBINE(prefix, t)* map);                      \
  void COMBINE(prefix, free)(COMBINE(prefix, t)* map);                      \
  void COMBINE(prefix, put)(COMBINE(prefix, t)* map, Tk key, Tv val);       \
  int COMBINE(prefix, get)(COMBINE(prefix, t)* map, Tk key, Tv* val);       \
  int COMBINE(prefix, del)(COMBINE(prefix, t)* map, Tk key, Tv* val);       \

#define MAKE_MAP_CODE(Tk, Tv, prefix)                                       \
  void COMBINE(prefix, init)(COMBINE(prefix, t)* map) {                     \
    memset(map, 0, sizeof(*map));                                           \
  }                                                                         \
                                                                            \
  void COMBINE(prefix, free)(COMBINE(prefix, t)* map) {                     \
    if (map->keys) { free(map->keys); }                                     \
    if (map->values) { free(map->values); }                                 \
    memset(map, 0, sizeof(*map));                                           \
  }                                                                         \
                                                                            \
  void COMBINE(prefix, put)(COMBINE(prefix, t)* map, Tk key, Tv val) {      \
    for (unsigned i=0; i < map->count; i++) {                               \
      if (MAP_EQUALS(map->keys[ i ], key)) {                                \
        map->values[ i ] = val;                                             \
        return;                                                             \
      }                                                                     \
    }                                                                       \
    if (map->count >= map->allocated) {                                     \
      map->allocated = map->count + 16;                                     \
      map->keys = realloc(                                                  \
        map->keys,                                                          \
        sizeof(Tk) * map->allocated                                         \
      );                                                                    \
      if (map->keys == NULL) { abort(); }                                   \
      map->values = realloc(                                                \
        map->values,                                                        \
        sizeof(Tk) * map->allocated                                         \
      );                                                                    \
      if (map->values == NULL) { abort(); }                                 \
    }                                                                       \
    map->keys[ map->count ] = key;                                          \
    map->values[ map->count ] = val;                                        \
    ++(map->count);                                                         \
  }                                                                         \
                                                                            \
  int COMBINE(prefix, get)(COMBINE(prefix, t)* map, Tk key, Tv* val) {      \
    for (unsigned i=0; i < map->count; i++) {                               \
      if (MAP_EQUALS(map->keys[ i ], key)) {                                \
        *val = map->values[ i ];                                            \
        return 0;                                                           \
      }                                                                     \
    }                                                                       \
    return ~0;                                                              \
  }                                                                         \
                                                                            \
  int COMBINE(prefix, del)(COMBINE(prefix, t)* map, Tk key, Tv* val) {      \
    for (unsigned i=0; i < map->count; i++) {                               \
      if (MAP_EQUALS(map->keys[ i ], key)) {                                \
        if (val) {                                                          \
          *val = map->values[ i ];                                          \
        }                                                                   \
        memmove(                                                            \
          &(map->keys[ i ]),                                                \
          &(map->keys[ i + 1]),                                             \
          sizeof(Tk) * (map->count - (i+1))                                 \
        );                                                                  \
        memmove(                                                            \
          &(map->values[ i ]),                                              \
          &(map->values[ i + 1]),                                           \
          sizeof(Tv) * (map->count - (i+1))                                 \
        );                                                                  \
        --(map->count);                                                     \
        if (map->count == 0) {                                              \
          free(map->keys);                                                  \
          free(map->values);                                                \
          map->keys = 0;                                                    \
          map->values = 0;                                                  \
          map->allocated = 0;                                               \
        } else if (map->count < map->allocated - 32) {                      \
          map->allocated = map->count + 16;                                 \
          map->keys = realloc(                                              \
            map->keys,                                                      \
            sizeof(Tk) * map->allocated                                     \
          );                                                                \
          if (map->keys == NULL) { abort(); }                               \
          map->values = realloc(                                            \
            map->values,                                                    \
            sizeof(Tv) * map->allocated                                     \
          );                                                                \
          if (map->values == NULL) { abort(); }                             \
        }                                                                   \
        return 0;                                                           \
      }                                                                     \
    }                                                                       \
    return ~0;                                                              \
  }                                                                         \

#endif
