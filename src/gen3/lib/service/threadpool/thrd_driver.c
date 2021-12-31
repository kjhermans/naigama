#include "threadpool.h"

/*
** PRIVATE
**
** Describes the life of a worker thread, that is:
** - it executes a job if it has one.
** - it waits until it drops out of the call to pthread_cond_wait(), which is
**   posted by thrdpl_do_job().
*/

void wthrd_driver(wthrd_t* thread) {
  if (pthread_mutex_lock(&(thread->mutex)) == 0) {
    while (!(thread->interrupted)) {
      if (thread->currentjob != NULL) {
        int r;
        if ((r = thread->currentjob->fp(thread, thread->arg)) != 0) {
          fprintf(thread->threadpool->log,
                  "%s: Ended in %d.\n",
                  thread->currentjob->name,
                  r);
        }
        free(thread->arg);
        thread->currentjob = NULL;
        thrdpl_relnq_thread(thread->threadpool, thread);
      }
      pthread_cond_wait(&(thread->condition), &(thread->mutex));
    }
    pthread_mutex_unlock(&(thread->mutex));
  }
}
