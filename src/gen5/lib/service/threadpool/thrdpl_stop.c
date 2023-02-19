#include "threadpool.h"

void thrdpl_stop
  (thrdpl_t* pool)
{
  unsigned i;

  if (pthread_mutex_lock(&(pool->mutex)) == 0) {
    for (i=0; i < pool->all.size; i++) {
      wthrd_t* thread = pool->all.list[ i ];
      wthrd_stop(thread);
    }
    pthread_mutex_unlock(&(pool->mutex));
  }
}
