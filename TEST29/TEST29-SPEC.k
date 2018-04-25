module TEST29-SPEC
  imports TEST29

rule
  <k> task   =>  . </k>
  <state> 
    "AB" |-> ( mi(64,?I:Int) => _ ) 
  </state>
endmodule
