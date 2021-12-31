all:
	perl $(SYSTEMTESTROOT)/bin/xsdcompile ./xsd/JDSSDM-1.1-Root.xsd \
		> /tmp/test.px || exit -1
	perl $(SYSTEMTESTROOT)/bin/perl2xmlpeg /tmp/test.px \
		> /tmp/test.naig || exit -1
	$(SYSTEMTESTROOT)/bin/naic -i /tmp/test.naig \
		-a /tmp/test.asm -o /tmp/test.byc || exit -1
	./execute.sh && \
		echo "SUCCESS"
