TARGET=naic
CC=$(ARCH)gcc
CFLAGS=-g -O2 -Wall -Wextra $(DEBUG) -I$(BUILDROOT)/src/gen1/include
LIBS=\
	$(BUILDROOT)/src/gen1/lib/compiler/libnaic.a \
	$(BUILDROOT)/src/gen1/lib/engine/libnaie.a \
	$(BUILDROOT)/src/gen1/lib/util/libutil.a

all: $(TARGET)

$(TARGET): compiler.o $(LIBS)
	$(CC) -o $(TARGET) compiler.o $(LIBS)

clean:
	@rm -f $(TARGET) compiler.o

superclean: clean

$(BUILDROOT)/src/gen1/lib/compiler/libnaic.a:
	@cd $(BUILDROOT)/src/gen1/lib/compiler && make

$(BUILDROOT)/src/gen1/lib/engine/libnaie.a:
	@cd $(BUILDROOT)/src/gen1/lib/engine && make

$(BUILDROOT)/src/gen1/lib/util/libutil.a:
	@cd $(BUILDROOT)/src/gen1/lib/util && make
