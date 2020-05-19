JAVAFILES:=$(shell find . -type f | grep '\.java$$')
CLASSFILES:=$(shell find . -type f | grep '\.java$$' | sort | sed -e 's/\.java$$/.class/')
JAVAC=javac
JAR=jar

all: phase1 phase2 phase3

phase1: generation

generation: ./com/kj/naigama/general/NaigamaInstructions.java

./com/kj/naigama/general/NaigamaInstructions.java: ../../instructions.pl
	perl ./generate.pl ../../instructions.pl > \
	  ./com/kj/naigama/general/NaigamaInstructions.java

phase2: classfiles

classfiles: $(CLASSFILES)

phase3: jarring

jarring: naigama.jar

naigama.jar: $(CLASSFILES)
	jar -cvf naigama.jar $(CLASSFILES)

clean:
	@find . -type f | grep '\.class\|\.jar' | xargs -r rm -f

superclean: clean
	rm -f ./com/kj/naigama/general/NaigamaInstructions.java

%.class: %.java
	$(JAVAC) -classpath . $<
