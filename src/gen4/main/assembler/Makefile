CC=$(ARCH)gcc
AR=$(ARCH)ar
CURGEN?=../..
CFLAGS=-g -Wall -Wextra $(DEBUG) -I$(CURGEN)/include
LIBS=\
  ../../lib/assembler/libnaia.a \
  ../../lib/util/libutil.a \
  ../../lib/parser/libnaip.a \
  ../../lib/naigama/libnaig.a \

all: naia

naia: main.o $(LIBS)
	$(CC) main.o -o naia $(LIBS)

clean:
	rm -f main.o naia
