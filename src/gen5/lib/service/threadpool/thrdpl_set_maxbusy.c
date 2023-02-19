#include "threadpool.h"

void thrdpl_set_maxbusy(thrdpl_t* pool, int maxbusy) {
  if (pool && maxbusy > 0) {
    pool->maxbusy = maxbusy;
    //.. check up on cxl_count(&(pool->busy))
  }
}
