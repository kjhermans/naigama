TARGET=sqldb
INCLUDE=$(NAIGROOT)/src/$(DEPGEN)/include
LIBDIR=$(NAIGROOT)/src/$(DEPGEN)/lib
LIBS=$(LIBDIR)/engine/libnaie.a $(LIBDIR)/memio/libnaio.a $(LIBDIR)/util/libutil.a 
DBLIB:=$(shell if [ $(USE_SLEEPYCAT) = 1 ]; then \
        echo "-ldb"; \
    else \
        echo "../sdbm_tree/libbtree.a"; \
    fi)
SQLLIB=../lib/libsqldb.a
SC:=$(shell if [ $(USE_SLEEPYCAT) = 1 ]; then \
        echo "-D_USE_SLEEPYCAT"; \
    else \
        echo ""; \
    fi)
CFLAGS=-g -Wall -Wextra $(DEBUG) -I$(INCLUDE) $(SC)

all: $(TARGET)

$(TARGET): main.c $(SQLLIB)
	$(CC) main.c $(CFLAGS) $(SQLLIB) -o $(TARGET) $(LIBS) $(DBLIB) -lm

$(SQLLIB):
	cd ../lib && make

clean:
	rm $(TARGET)
