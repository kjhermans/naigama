#include "threadpool.h"

/*
** Returns a thread from the non busy stack,
** or blocks until a thread becomes available.
*/

wthrd_t* thrdpl_get_thread
  (thrdpl_t* pool)
{
  wthrd_t* thread = NULL;

  while (thread == NULL) {
    if (pthread_mutex_lock(&(pool->mutex)) == 0) {
      if (pool->free.size == 0) {
        if (pool->busy < pool->maxbusy) {
          thread = wthrd_new(pool);
        } else {
          pthread_cond_wait(&(pool->condition), &(pool->mutex));
        }
      } else {
        thread = pool->free.list[ --(pool->free.size) ];
        ++(pool->busy);
      }
      pthread_mutex_unlock(&(pool->mutex));
    }
  }
  return thread;
}
