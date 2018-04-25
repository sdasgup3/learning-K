module TEST27-SPEC
  imports TEST27

rule
  <k> oldinst1(2) oldinst2(3)  => .Tasks </k>
  <state> MI:MInt => _ </state>
endmodule
