all:
	$(SYSTEMTESTROOT)/bin/naic -i ./test.naig \
		-o /tmp/test.asm || exit -1
	$(SYSTEMTESTROOT)/bin/naia -i ./test.asm \
		-o /tmp/test.byc || exit -1
	./execute.sh && \
		echo "SUCCESS"
