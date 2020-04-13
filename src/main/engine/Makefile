TARGET=naie
CC=$(ARCH)gcc
CFLAGS=-I../../include -g -O2 -Wall -Wextra $(DEBUG)
LIBS=\
	../../lib/engine/libnaie.a \
	../../lib/util/libutil.a

all: $(TARGET)

$(TARGET): engine.o $(LIBS)
	$(CC) -o $(TARGET) engine.o $(LIBS)

clean:
	@rm -f $(TARGET) engine.o

superclean: clean

../../lib/engine/libnaie.a:
	@cd ../../lib/engine && make

../../lib/util/libutil.a:
	@cd ../../lib/util && make
