TARGET=naia
CC=$(ARCH)gcc
CFLAGS=-I../../include -g -O2 -Wall -Wextra $(DEBUG)
LIBS=\
	../../lib/assembler/libnaia.a \
	../../lib/engine/libnaie.a \
	../../lib/util/libutil.a

all: $(TARGET)

$(TARGET): assembler.o $(LIBS)
	$(CC) -o $(TARGET) assembler.o $(LIBS)

clean:
	@rm -f $(TARGET) assembler.o

superclean: clean

../../lib/assembler/libnaia.a:
	@cd ../../lib/assembler && make

../../lib/engine/libnaie.a:
	@cd ../../lib/engine && make

../../lib/util/libutil.a:
	@cd ../../lib/util && make
