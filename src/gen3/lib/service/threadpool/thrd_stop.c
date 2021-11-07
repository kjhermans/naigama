#include "threadpool.h"

void wthrd_stop(wthrd_t* thread) {
  if (pthread_mutex_lock(&(thread->mutex)) == 0) {
    thread->interrupted = 1;
    pthread_cond_signal(&(thread->condition));
    pthread_mutex_unlock(&(thread->mutex));
  }
}
