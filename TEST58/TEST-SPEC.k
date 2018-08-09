module TEST-SPEC
  imports TEST

rule
  <k>  task => . </k>
  <state> 
    "AB" |-> (mi(64, N:Int) => _)  
  </state>

endmodule
