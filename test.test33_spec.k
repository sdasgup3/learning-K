module TEST33-SPEC
  imports TEST33

rule
  <k>  task => . </k>
  <state> 
    "AB" |-> (mi(64, I1:Int) => _)  
    "CD" |-> (mi(64, I2:Int) => _)  
    "EF" |-> (mi(64, I3:Int) => _)  
    "GH" |-> (?B:Bool => _)
  </state>

endmodule
