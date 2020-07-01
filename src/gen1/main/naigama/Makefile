TARGET=naig
CC=$(ARCH)gcc
CFLAGS=-g -O2 -Wall -Wextra $(DEBUG) -I$(BUILDROOT)/src/gen1/include
LIBS=$(BUILDROOT)/src/gen1/lib/naigama/libnaigama.a

all: $(TARGET)

OBJECTS=naigama.o

$(TARGET): $(OBJECTS) $(LIBS)
	$(CC) -o $(TARGET) $(OBJECTS) $(LIBS)

clean:
	@rm -f $(TARGET) $(OBJECTS)

superclean: clean

$(BUILDROOT)/src/gen1/lib/naigama/libnaigama.a:
	@cd $(BUILDROOT)/src/gen1/lib/naigama && make
