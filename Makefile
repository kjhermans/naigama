all: stage_0 stage_1 stage_2 stage_3 stage_4

debug:
	@export DEBUG=-D_DEBUG && make

arm_bare_metal:
	@export ARCH=arm-none-eabi- && make

stage_0:
	@MFS=`find src/ doc/ -name Makefile | xargs grep -l stage_0`; \
		for MF in $$MFS; do \
			DIR=`dirname $$MF`; \
			make -C $$DIR stage_0; \
		done

stage_1:
	@MFS=`find src/ doc/ -name Makefile | xargs grep -l stage_1`; \
		for MF in $$MFS; do \
			DIR=`dirname $$MF`; \
			make -C $$DIR stage_1; \
		done

stage_2:
	@MFS=`find src/ doc/ -name Makefile | xargs grep -l stage_2`; \
		for MF in $$MFS; do \
			DIR=`dirname $$MF`; \
			make -C $$DIR stage_2; \
		done

stage_3:
	@MFS=`find src/ doc/ -name Makefile | xargs grep -l stage_3`; \
		for MF in $$MFS; do \
			DIR=`dirname $$MF`; \
			make -C $$DIR stage_3; \
		done

stage_4:
	@MFS=`find src/ doc/ -name Makefile | xargs grep -l stage_4`; \
		for MF in $$MFS; do \
			DIR=`dirname $$MF`; \
			make -C $$DIR stage_4; \
		done

archive: clean
	RELEASE=$$(cat release); \
	/bin/echo "  [TAR] ~/naigama-src-$$RELEASE.tar.gz"; \
	cd .. && tar czf ~/naigama-src-$$RELEASE.tar.gz --exclude=\.git naigama/

clean:
	@MFS=`find src/ doc/ -name Makefile`; \
		for MF in $$MFS; do \
			DIR=`dirname $$MF`; \
			make -C $$DIR clean; \
		done

superclean:
	@MFS=`find src -name Makefile`; \
		for MF in $$MFS; do \
			DIR=`dirname $$MF`; \
			make -C $$DIR superclean; \
		done

test:
	@cd t/ && make

doc:
	@cd d/ && make

install:
	@sudo cp src/main/engine/naie \
		src/main/compiler/naic \
		src/main/assembler/naia \
		/usr/local/bin/

java:
	@cd src/java && make
