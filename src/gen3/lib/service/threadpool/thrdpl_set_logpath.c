#include "threadpool.h"

void thrdpl_set_logpath(thrdpl_t* pool, char* path) {
  if (pool && path) {
    thrdpl_set_logfile(pool, fopen(path, "a"));
  }
}
