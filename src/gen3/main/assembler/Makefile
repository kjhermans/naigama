TARGET=naia
CC=$(ARCH)gcc
CFLAGS=-g -O2 -Wall -Wextra $(DEBUG) -I$(BUILDROOT)/src/gen3/include
LIBS=\
	$(BUILDROOT)/src/gen3/lib/assembler/libnaia.a \
	$(BUILDROOT)/src/gen3/lib/engine/libnaie.a \
	$(BUILDROOT)/src/gen3/lib/util/libutil.a

all: $(TARGET)

$(TARGET): assembler.o $(LIBS)
	$(CC) -o $(TARGET) assembler.o $(LIBS)

clean:
	@rm -f $(TARGET) assembler.o

superclean: clean

$(BUILDROOT)/src/gen3/lib/assembler/libnaia.a:
	@cd $(BUILDROOT)/src/gen3/lib/assembler && make

$(BUILDROOT)/src/gen3/lib/engine/libnaie.a:
	@cd $(BUILDROOT)/src/gen3/lib/engine && make

$(BUILDROOT)/src/gen3/lib/util/libutil.a:
	@cd $(BUILDROOT)/src/gen3/lib/util && make
