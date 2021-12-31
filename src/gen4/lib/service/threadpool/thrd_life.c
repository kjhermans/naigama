#include <stdlib.h>

#include "threadpool.h"

/*
** PRIVATE
**
** Creates a thread and runs it.  Threads, and the structures they reside in,
** and also the code they reside in, are pretty much self-sufficient;
** once created, it only posts itself back into the threadpool queue if
** it's not busy, otherwise, the parent structure does not really know
** about it.
*/

void wthrd_del(wthrd_t* thread) {
  pthread_mutex_destroy(&(thread->mutex));
  pthread_cond_destroy(&(thread->condition));
  free(thread);
}

static
void* wthrd_new_delegate(void* arg) {
  wthrd_t* thread = (wthrd_t*)arg;
  wthrd_driver(thread);
  return NULL;
}

wthrd_t* wthrd_new(thrdpl_t* pool) {
  wthrd_t* thread = NEW(wthrd_t);
  if (thread) {
    pool->all.list = realloc(pool->all.list, sizeof(wthrd_t*) * (pool->all.size + 1));
    pool->all.list[ (pool->all.size)++ ] = thread;
    pthread_mutex_init(&(thread->mutex), NULL);
    pthread_cond_init(&(thread->condition), NULL);
    thread->threadpool = pool;
    if (pthread_create(&(thread->thread), NULL, wthrd_new_delegate, thread)) {
      free(thread);
      return NULL;
    }
  }
  return thread;
}
