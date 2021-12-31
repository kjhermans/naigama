
/*
** PUBLIC
** 
** Assigns a job to a thread, and then signals the condition waiting
** inside the thread driver to go and do it.
**
** MAY BLOCK inside the call to thrdpl_get_thread(),
** if the amount of threads has exceeded its maximum.
*/

#include <string.h>

#include "threadpool.h"

int thrdpl_do_job
  (thrdpl_t* pool, int j, void* buf, unsigned size)
{
  if (j >= 0 && j < pool->jobs.size) {
    job_t* job = pool->jobs.list[ j ];
    wthrd_t* thread = thrdpl_get_thread(pool);
    if (thread) {
      void* copy = malloc(size);
      if (copy == NULL) {
        return ~0;
      }
      memcpy(copy, buf, size);
      if (pthread_mutex_lock(&(thread->mutex)) == 0) {
        thread->currentjob = job;
        thread->arg = copy;
        pthread_cond_signal(&(thread->condition));
        pthread_mutex_unlock(&(thread->mutex));
        return 0;
      }
    }
  }
  return ~0;
}
