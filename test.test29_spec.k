module TEST29-SPEC
  imports TEST29

rule
  <k> task   =>  . </k>
  <state> 
    "AB" |-> ( mi(64,?I:Int):MInt => _ ) 
  </state>
endmodule
