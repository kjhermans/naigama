#ifndef _THREADPOOL_H_
#define _THREADPOOL_H_

#include <stdlib.h>
#include <stdio.h>
#include <pthread.h>
#include <semaphore.h>

/*
** Structures needed to provide a workerthread pool.
*/

typedef struct thrd wthrd_t;
typedef struct thrdpl thrdpl_t;
typedef struct job job_t;

struct thrd {

    /*
    ** 
    */
        thrdpl_t*       threadpool;

    /*
    ** 
    */
        pthread_t       thread;

    /*
    **
    */
        pthread_mutex_t mutex;
        pthread_cond_t  condition;

    /*
    ** 
    */
        job_t*          currentjob;

    /*
    ** 
    */
        void*           arg;

    /*
    **
    */
        int             interrupted;

};

struct job {

    /*
    ** 
    */
        char            name[128];

    /*
    ** 
    */
        int             (*fp)(wthrd_t*,void*);

};

struct thrdpl {

    /*
    ** The actual amount of threads that are busy.
    */
        int             busy;

    /*
    ** The maximum amount of threads that can be busy.
    */
        int             maxbusy;

    /*
    ** Busy threads are out of sight; free threads are in this list.
    */
        struct {
          struct thrd**      list;
          unsigned           size;
        }                  free;

    /*
    ** All threads are put in this list when created.
    */
        struct {
          struct thrd**      list;
          unsigned           size;
        }                  all;

    /*
    ** The mutex and condition to guard the free threads list.
    */
        pthread_mutex_t mutex;
        pthread_cond_t  condition;

    /*
    ** The list of possible jobs to insert.
    */
        struct {
          struct job**       list;
          unsigned           size;
        }                  jobs;

    /*
    ** The logfile that reports the jobs that returned non zero.
    */
        FILE*           log;

};

/*
** Functions that deal with the threadpool's lifetime.
*/

thrdpl_t* thrdpl_init(thrdpl_t* pool);
void      thrdpl_free(thrdpl_t* pool);

/*
** Call these functions before inserting jobs.
*/

void      thrdpl_set_maxbusy(thrdpl_t* pool, int maxbusy);
void      thrdpl_set_logfile(thrdpl_t* pool, FILE* logfile);
void      thrdpl_set_logpath(thrdpl_t* pool, char* path);
int       thrdpl_add_job(thrdpl_t* pool, int (*fp)(wthrd_t*,void*), char* name);

/*
** Insert a job.  Expect not to block when the pool is spacious enough
** to handle all of your requests.  Does block when all of your workerthreads
** are taken, though, and it's not allowed to make more.
*/

int       thrdpl_do_job(thrdpl_t* pool, int job, void* buf, unsigned size);

/*
** And when you're done..
*/

void      thrdpl_stop(thrdpl_t* pool);

/*
** PRIVATE
*/

wthrd_t*   wthrd_new(thrdpl_t*);
wthrd_t*   thrdpl_get_thread(thrdpl_t*);
void       thrdpl_relnq_thread(thrdpl_t*, wthrd_t*);
void       wthrd_driver(wthrd_t*);
void       wthrd_stop(wthrd_t*);

#define NEW(typ) ((typ*)calloc(1,sizeof(typ)))

#endif
