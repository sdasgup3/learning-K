module TEST26-SPEC
  imports TEST26

rule
  <k> test(1)  => . </k>
  <state> mi(64,10) => mi(64,11) </state>

rule
  <k> test(1) test(2) => .Tasks </k>
  <state> mi(64,10) => mi(64,13) </state>
endmodule
