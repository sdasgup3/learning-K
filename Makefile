TESTS=$(shell find . -maxdepth 1  -type d -name "*.k" | sort -V)
SPECS=$(shell find . -maxdepth 1  -type d -name "*.spec.k" | sort -V)
.PHONY:	${TESTS}  all clean

RUNSTATES=$(patsubst %.s, %, $(TESTS))
RUNSPECS=$(patsubst %_spec.k, %_spec, $(SPECS))

Y=$(shell echo TEST11.k | cut -d '.' -f 1 | tr A-Z a-z)

all clean: ${TESTS}

.ONESHELL:
%:%.k
		rm -rf *-kompiled;
		kompile $< --debug -v;
		X=$$(echo $< | cut -d '.' -f 1 | tr A-Z a-z);
		krun test.$${X} --debug

%_spec:%_spec.k
		X=$$(echo $< | cut -d '.' -f 1 | tr A-Z a-z);
		krun --prove $< dummy.k  --smt_prelude /home/sdasgup3/Github/k/k-distribution/include/z3/basic.smt2
