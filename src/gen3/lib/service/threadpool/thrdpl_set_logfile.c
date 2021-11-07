#include "threadpool.h"

void thrdpl_set_logfile(thrdpl_t* pool, FILE* file) {
  if (pool && file) {
    pool->log = file;
  }
}
