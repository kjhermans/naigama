CC=$(ARCH)gcc
AR=$(ARCH)ar
CURGEN?=../..
CFLAGS=-g -Wall -Wextra $(DEBUG) -I$(CURGEN)/include
LIBS=\
  ../../lib/disassembler/libnaid.a \
  ../../lib/util/libutil.a \
  ../../lib/engine/libnaie.a \
  ../../lib/naigama/libnaig.a \

all: naid

naid: main.o $(LIBS)
	$(CC) main.o -o naid $(LIBS)

clean:
	rm -f main.o naid
