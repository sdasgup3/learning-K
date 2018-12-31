// Cannot use PointerVal as an argument of addMInt
// Macro
module TEST-SYNTAX
    imports DOMAINS-SYNTAX
    imports MINT

    syntax Task ::=  "test" "(" Int "," Int "," Int "," Int")" [function]
    syntax Task ::=  MInt
    syntax Tasks ::= List{Task, ""}

endmodule

module TEST
    imports TEST-SYNTAX

    configuration <k>$PGM:Tasks</k>

    syntax PointerVal ::= ptr(Int, /* offset in bits */ MInt)
   syntax Int ::= getMemLoc(PointerVal) [function]
  syntax MInt ::= getMIntVal(PointerVal) [function]

   rule getMemLoc(ptr(L:Int, MI:MInt)) => L
  rule getMIntVal(ptr(L:Int, MI:MInt)) => MI


    rule addMInt(PV1:PointerVal, PV2:PointerVal) => 
      ptr(getMemLoc(PV1), addMInt(getMIntVal(PV1), getMIntVal(PV2)))

    rule T:Task Ts:Tasks => T ~> Ts

    rule test(W1:Int, I1:Int, W2:Int, I2:Int) =>
      addMInt(ptr(10, mi(W1, I1)), ptr(10, mi(W2, I2)))
    
endmodule
