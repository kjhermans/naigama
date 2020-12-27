all: gen0 gen1 gen2 gen3

gen0:
	@cd src/gen0 && make

gen1: gen0
	@cd src/gen1 && make

gen2: gen1
	@cd src/gen2 && make

gen3: gen2
	@cd src/gen3 && make

clean:
	@MFS=`find src/ d/ -name Makefile | xargs grep -l 'clean:'`; \
		for MF in $$MFS; do \
			DIR=`dirname $$MF`; \
			make -C $$DIR clean; \
		done

superclean: clean
	@MFS=`find src/ d/ -name Makefile | xargs grep -l 'superclean:'`; \
		for MF in $$MFS; do \
			DIR=`dirname $$MF`; \
			make -C $$DIR superclean; \
		done

archive: clean
	RELEASE=$$(cat release); \
	/bin/echo "  [TAR] ~/naigama-src-$$RELEASE.tar.gz"; \
	cd .. && \
	  tar czf ~/naigama-src-$$RELEASE.tar.gz --exclude=\.git naigama/
