module TEST33-SPEC
  imports TEST33

rule
  <k>  task => . </k>
  <state> 
    "AB" |-> (mi(64, I1:Int) => _)  
    "CD" |-> (mi(64, I2:Int) => _)  
    "YMM" |-> (mi(256, I1:Int) => _)
      "F" |-> (mi(1, IF:Int) => _)
      "CF" |-> ( mi(1, ICF:Int) => _)

      /*
    "CD2" |-> (mi(64, I2:Int) => _)  
    "EF" |-> (mi(64, I3:Int) => _)  
    "GH" |-> (?B:Bool => _)

    "BW1" |-> (?I:Int => _)
    "BW2" |-> (?I:Int => _)
    "BW3" |-> (?I:Int => _)
    "BW4" |-> (?I:Int => _)
    "BW5" |-> (?I:Int => _)
    "BW6" |-> (?I:Int => _)
    "BW7" |-> (?I:Int => _)
    "BW8" |-> (?MI:MInt => _)
    "BW9" |-> (?I:Int => _)
    "BW10" |-> (?I:Int => _)
    "BW11" |-> (?I:Int => _)
    "BW12" |-> (?MI2:MInt => _)
    "BW13" |-> (?MI3:MInt => _)
    "BW14" |-> (?I3:Int => _)
    "BW15" |-> (mi(64, I15:Int) => _)
    "BW16" |-> (mi(64, I16:Int) => _)
    "BW17" |-> (mi(64, I17:Int) => _)
    */
    "BW18" |-> (mi(64, I18:Int) => _)
  </state>

endmodule
