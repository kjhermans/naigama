TARGET=naic
CC=$(ARCH)gcc
CFLAGS=-I../../include -g -O2 -Wall -Wextra $(DEBUG)
LIBS=\
	../../lib/compiler/libnaic.a \
	../../lib/engine/libnaie.a \
	../../lib/util/libutil.a

all: $(TARGET)

$(TARGET): compiler.o $(LIBS)
	$(CC) -o $(TARGET) compiler.o $(LIBS)

clean:
	@rm -f $(TARGET) compiler.o

superclean: clean

../../lib/compiler/libnaic.a:
	@cd ../../lib/compiler && make

../../lib/engine/libnaie.a:
	@cd ../../lib/engine && make

../../lib/util/libutil.a:
	@cd ../../lib/util && make
