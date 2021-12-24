JAVAC=javacJAVAFILES:=$(shell find . -type f | grep '\.java$$')
CLASSFILES:=$(shell find . -type f | grep '\.java$$' | sort | sed -e 's/\.java$$/.class/')
JAVAC=javac
JAR=jar
TARGET=naigama.jar
NAIE=naie.jar
NAIC=naic.jar
NAIA=naia.jar
TARGETS=$(TARGET) $(NAIE) $(NAIC) $(NAIA)

all: $(TARGETS)

$(TARGET): $(CLASSFILES)
	$(JAR) cf $(TARGET) $(CLASSFILES)

$(NAIE): $(CLASSFILES)
	$(JAR) cfe $(NAIE) lib.naigama.engine.Main $(CLASSFILES)
	cat stub.sh $(NAIE) > jnaie && chmod 775 jnaie

$(NAIC): $(CLASSFILES)
	$(JAR) cfe $(NAIC) lib.naigama.compiler.Main $(CLASSFILES)
	cat stub.sh $(NAIC) > jnaic && chmod 775 jnaic

$(NAIA): $(CLASSFILES)
	$(JAR) cfe $(NAIA) lib.naigama.assembler.Main $(CLASSFILES)
	cat stub.sh $(NAIA) > jnaia && chmod 775 jnaia

clean:
	rm -f $(CLASSFILES) $(TARGETS) jnaie jnaic jnaia

%.class: %.java
	$(JAVAC) -classpath . $<
