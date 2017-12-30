TESTS=$(shell find . -maxdepth 1  -type d -name "*.k" | sort -V)
.PHONY:	${TESTS}  all clean

RUNSTATES=$(patsubst %.s, /%, $(TESTS))
Y=$(shell echo TEST11.k | cut -d '.' -f 1 | tr A-Z a-z)

all clean: ${TESTS}

.ONESHELL:
%:%.k
		rm -rf *-kompiled;
		kompile $< --debug -v;
		X=$$(echo $< | cut -d '.' -f 1 | tr A-Z a-z);
		krun test.$${X} --debug
