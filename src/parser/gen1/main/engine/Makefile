TARGET=naie
CC=$(ARCH)gcc
CFLAGS=-g -O2 -Wall -Wextra $(DEBUG) -I$(BUILDROOT)/src/parser/include
LIBS=\
	$(BUILDROOT)/src/parser/gen1/lib/engine/libnaie.a \
	$(BUILDROOT)/src/parser/gen1/lib/util/libutil.a

all: $(TARGET)

OBJECTS=engine.o engine_replace.o

$(TARGET): $(OBJECTS) $(LIBS)
	$(CC) -o $(TARGET) $(OBJECTS) $(LIBS)

clean:
	@rm -f $(TARGET) $(OBJECTS)

superclean: clean

$(BUILDROOT)/src/parser/gen1/lib/engine/libnaie.a:
	@cd $(BUILDROOT)/src/parser/gen1/lib/engine && make

$(BUILDROOT)/src/parser/gen1/lib/util/libutil.a:
	@cd $(BUILDROOT)/src/parser/gen1/lib/util && make
