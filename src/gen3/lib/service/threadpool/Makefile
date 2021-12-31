# ./configure 
PREFIX=/usr/local/ehttpd
BINDIR=/usr/local/ehttpd/bin
LIBDIR=/usr/local/ehttpd/lib
INCLUDEDIR=/usr/local/ehttpd/include
DOCDIR=/usr/local/ehttpd/doc
TARGET=portald
CC=gcc
MODULE_LD_OPTIONS=-shared
ENDIAN=LITTLEENDIAN
CONFIG="/etc/ehttpd.conf"
PLATFORM=Linux
PROTOLDFLAGS=-lpthread -ldl -lpthread
PROTOCFLAGS=-I/home/kees/work/ehttpd -I/home/kees/work/ehttpd/src/httpd -I/home/kees/work/ehttpd/src/threadpool -I/home/kees/work/ehttpd/src/server -I/home/kees/work/ehttpd/src/ehttpd -g -Wall -D_HTTPD_STATE_FORK_ 
SHAREDFLAG=-shared
OBJECTS = \
  thrd_driver.o \
  thrd_life.o \
  thrd_stop.o \
  thrdpl_add_job.o \
  thrdpl_do_job.o \
  thrdpl_get_thread.o \
  thrdpl_life.o \
  thrdpl_stop.o \
  thrdpl_relnq_thread.o \
  thrdpl_set_logfile.o \
  thrdpl_set_logpath.o \
  thrdpl_set_maxbusy.o \


CFLAGS = $(PROTOCFLAGS)

TARGET = libthrdpl.a

all: $(OBJECTS) target

target: $(TARGET)

$(TARGET): $(OBJECTS)
	@/bin/echo "  Building archive"; ar -rcs $(TARGET) $(OBJECTS)

clean:
	rm -f $(OBJECTS) $(TARGET)

%.o: %.c
	@/bin/echo -n "  Compiling $< .. "; \
	if $(CC) $(CFLAGS) -c -o $@ $<; then \
	  /bin/echo "Ok"; \
	else \
	  /bin/echo "Failed: $(CC) $(CFLAGS) -c -o $@ $<"; \
	  exit -1; \
	fi
