#include <string.h>

#include "threadpool.h"

/*
** PUBLIC
*/

thrdpl_t* thrdpl_init(thrdpl_t* pool) {
  if (pool == NULL) {
    if ((pool = NEW(thrdpl_t)) == NULL) {
      return NULL;
    }
  } else {
    memset(pool, 0, sizeof(*pool));
  }
  pool->maxbusy = 16;  /** a reasonable figure **/
  pool->free.size = 0;
  pool->free.list = 0;
  pool->all.size = 0;
  pool->all.list = 0;
  pool->jobs.size = 0;
  pool->jobs.list = 0;
  pthread_mutex_init(&(pool->mutex), NULL);
  pthread_cond_init(&(pool->condition), NULL);
  pool->log = stderr;
  return pool;
}

void thrdpl_free(thrdpl_t* pool) {
  /*
  ** TODO: Signal all threads to come out of their hiding places and stop
  ** working.
  */
  thrdpl_stop(pool);
}
