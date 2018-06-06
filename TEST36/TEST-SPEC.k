module TEST-SPEC
  imports TEST

rule
  <k>  maintask => . </k>
  <state> 
    "CF" |-> (mi(1, I1:Int) => _)  
    "RAX" |-> (mi(64, I2:Int) => _)
  </state>


endmodule
