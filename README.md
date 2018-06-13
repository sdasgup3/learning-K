# learning-K
Learning Experience on defining language semantics using [K](https://github.com/kframework/k5)

# Usage
- To kompile a k-defintion and krun corresponding tests
  ```
  ~~make TEST26~~
  cat filelist.txt | parallel "echo {}; cd {}; kompile  {}.k --debug --backend java; cd .."
  cat filelist.txt | parallel "echo {}; cd {}; krun  {}.test --debug ; cd .."
  ```
- To krpove a spec
  ```
  ~~make test.test_spec~~
  cat filelist.txt | parallel "echo {}; cd {}; kprove {}-SPEC.k ../dummy.k --smt_prelude /home/sdasgup3/Github/k5/k-distribution/include/z3/basic.smt2 ; cd .."
  ```


# Contents

| Test Name  | Purpose  | 
|------------|----------|
| TEST41     | Passing config valriable using -c -p flags    |
| TEST52     | check maxFloat with Nan/mulfloat    |
| TEST49     | rol/ror     |
| TEST8     | shl/r     |
| TEST24     | shl/r     |
