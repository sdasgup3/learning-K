module TEST35-SPEC
  imports TEST35

rule
  <k>  task => . </k>
  <state> 
    "CF" |-> (mi(1, I1:Int) => _)  
    "RAX" |-> (mi(64, I2:Int) => _)
  </state>


endmodule
