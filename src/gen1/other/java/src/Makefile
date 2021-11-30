JAVAC=javacJAVAFILES:=$(shell find . -type f | grep '\.java$$')
CLASSFILES:=$(shell find . -type f | grep '\.java$$' | sort | sed -e 's/\.java$$/.class/')
JAVAC=javac
JAR=jar
TARGET=naigama.jar

all: $(TARGET)

$(TARGET): $(CLASSFILES)
	$(JAR) -cvf $(TARGET) $(CLASSFILES)

clean:
	rm -f $(CLASSFILES) $(TARGET)

%.class: %.java
	$(JAVAC) -classpath . $<
