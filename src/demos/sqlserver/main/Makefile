INCLUDE=$(NAIGROOT)/src/$(DEPGEN)/include
LIBDIR=$(NAIGROOT)/src/$(DEPGEN)/lib
LIBS=$(LIBDIR)/engine/libnaie.a $(LIBDIR)/memio/libnaio.a $(LIBDIR)/util/libutil.a
TARGET=sqldb
SQLLIB=../lib/libsqldb.a

all: $(TARGET)

$(TARGET): main.c $(SQLLIB)
	$(CC) main.c -I$(INCLUDE) $(SQLLIB) -o $(TARGET) -ldb $(LIBS) -lm

$(SQLLIB):
	cd ../lib && make

clean:
	rm $(TARGET)
