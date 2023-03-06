CC=$(ARCH)gcc
AR=$(ARCH)ar
CURGEN?=../..
CFLAGS=-g -Wall -Wextra $(DEBUG) -I$(CURGEN)/include
LIBS=\
  ../../lib/compiler/libnaic.a \
  ../../lib/util/libutil.a \
  ../../lib/parser/libnaip.a \
  ../../lib/naigama/libnaig.a \

all: naic

naic: main.o $(LIBS)
	$(CC) main.o -o naic $(LIBS)

clean:
	rm -f main.o naic
