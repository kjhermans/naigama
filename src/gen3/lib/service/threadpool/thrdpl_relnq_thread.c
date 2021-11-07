#include "threadpool.h"

/*
** PRIVATE
**
** Pushes the thread in question back onto the non-busy stack
** and signals anyone who might be waiting for a thread to be relinquished.
*/

void thrdpl_relnq_thread(thrdpl_t* pool, wthrd_t* thread) {
  if (pthread_mutex_lock(&(pool->mutex)) == 0) {
    pool->free.list = realloc(pool->free.list, sizeof(wthrd_t*) * (pool->free.size + 1));
    pool->free.list[ (pool->free.size)++ ] = thread;
    --(pool->busy);
    pthread_cond_signal(&(pool->condition));
    pthread_mutex_unlock(&(pool->mutex));
  }
}
