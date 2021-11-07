#include "threadpool.h"

#include <string.h>

int thrdpl_add_job(thrdpl_t* pool, int (*fp)(wthrd_t*,void*), char* name) {
  if (pool && fp) {
    job_t* job = NEW(job_t);
    job->fp = fp;
    if (name) strncpy(job->name, name, 127);
    pool->jobs.list = realloc(pool->jobs.list, sizeof(job_t*) * (pool->jobs.size + 1));
    pool->jobs.list[ (pool->jobs.size)++ ] = job;
    return pool->jobs.size - 1;
  }
  return -1;
}
