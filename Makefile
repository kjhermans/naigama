NAIGROOT=$(shell pwd)
NAIGRELEASE=$(shell cat release | tr -d '\n')

all: makerelease gen0 gen1 gen2 gen3

world: superclean archive all other test demos doc

debug:
	make all DEBUG="-D_DEBUG=1"

makerelease: ./src/gen0/include/naigama/release.h

./src/gen0/include/naigama/release.h: release
	echo -n '#define NAIGAMA_RELEASE "' \
		> ./src/gen0/include/naigama/release.h
	cat release | tr -d '\n' >> ./src/gen0/include/naigama/release.h
	echo '"' >> ./src/gen0/include/naigama/release.h

gen0:
	@cd src/gen0 && make \
		CURGEN=$(NAIGROOT)/src/gen0

gen1: gen0
	@cd src/gen1 && make \
		CURGEN=$(NAIGROOT)/src/gen1 \
		PREVGEN=$(NAIGROOT)/src/gen0

gen2: gen1
	@cd src/gen2 && make \
		CURGEN=$(NAIGROOT)/src/gen2 \
		PREVGEN=$(NAIGROOT)/src/gen1

gen3: gen2
	@cd src/gen3 && make \
		CURGEN=$(NAIGROOT)/src/gen3 \
		PREVGEN=$(NAIGROOT)/src/gen2

armbm:
	@make all ARCH=arm-linux-gnueabi-

other: rust java perl

rust: gen1
	@cd src/gen3 && make rust NAIGRELEASE=$(NAIGRELEASE)

java: gen1
	@cd src/gen3 && make java

perl: gen1
	@cd src/gen3 && make perl

doc:
	@MFS=`find src/ -name Makefile | xargs grep -l 'doc:'`; \
		for MF in $$MFS; do \
			DIR=`dirname $$MF`; \
			make -C $$DIR doc; \
		done

test: test0 test1 test2 test3

test0:
	cd src/gen0 && make test

test1:
	cd src/gen1 && make test

test2:
	cd src/gen2 && make test

test3:
	cd src/gen3 && make test

demos:
	cd src/demos && make NAIGROOT=$(NAIGROOT)

clean:
	@MFS=`find src/ -name Makefile | xargs grep -l 'clean:'`; \
		for MF in $$MFS; do \
			DIR=`dirname $$MF`; \
			make -C $$DIR clean; \
		done

superclean: clean
	@MFS=`find src/ -name Makefile | xargs grep -l 'superclean:'`; \
		for MF in $$MFS; do \
			DIR=`dirname $$MF`; \
			make -C $$DIR superclean; \
		done

archive: clean
	RELEASE=$$(cat release); \
	/bin/echo "  [TAR] ~/oroszlan-src-$$RELEASE.tar.gz"; \
	cd .. && \
	  tar czf archive/oroszlan-src-$$RELEASE.tar.gz \
	  --exclude=\.git oroszlan/

gen0_test:
	cd src/gen0 && make test

gen1_test:
	cd src/gen1 && make test

gen2_test:
	cd src/gen2 && make test

gen3_test:
	cd src/gen3 && make test

gen1_other_java:
	cd src/gen1/other/java && make

gen1_other_java_test: gen1_other_java
	cd src/gen1/other/java/t/ && make
