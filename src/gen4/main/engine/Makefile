TARGET=naie
CC=$(ARCH)gcc
AR=$(ARCH)ar
CURGEN?=../..
CFLAGS=-g -Wall -Wextra $(DEBUG) -I$(CURGEN)/include
LIBS=\
  ../../lib/engine/libnaie.a \
  ../../lib/util/libutil.a \
  ../../lib/parser/libnaip.a \
  ../../lib/naigama/libnaig.a \

all: $(TARGET)

$(TARGET): main.o $(LIBS)
	$(CC) main.o -o $(TARGET) $(LIBS)

clean:
	rm -f main.o $(TARGET)
