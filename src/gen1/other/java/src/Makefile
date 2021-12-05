JAVAC=javacJAVAFILES:=$(shell find . -type f | grep '\.java$$')
CLASSFILES:=$(shell find . -type f | grep '\.java$$' | sort | sed -e 's/\.java$$/.class/')
JAVAC=javac
JAR=jar
TARGET=naigama.jar
NAIE=naie.jar
NAIC=naic.jar
TARGETS=$(TARGET) $(NAIE) $(NAIC)

all: $(TARGETS)

$(TARGET): $(CLASSFILES)
	$(JAR) cf $(TARGET) $(CLASSFILES)

$(NAIE): $(CLASSFILES)
	$(JAR) cfe $(NAIE) lib.naigama.engine.Main $(CLASSFILES)

$(NAIC): $(CLASSFILES)
	$(JAR) cfe $(NAIC) lib.naigama.compiler.Main $(CLASSFILES)

clean:
	rm -f $(CLASSFILES) $(TARGETS)

%.class: %.java
	$(JAVAC) -classpath . $<
