// HexConstant
// Macro
module TEST-SYNTAX
    imports DOMAINS-SYNTAX
    imports K-REFLECTION
    imports MINT

    syntax Task ::=  "test" "(" Int ")" [function]
    syntax Task ::=  "test" "(" Int "," Int  ")" [function]
    syntax Tasks ::= List{Task, ""}

    syntax PointerVal ::= "ptr" "(" Int "," MInt ")" 


  syntax MInt ::= PointerVal
  syntax Int ::= getMemLoc(PointerVal) [function]
  syntax MInt ::= getMIntVal(PointerVal) [function]
  syntax MInt ::= "concatenatePV" "(" MInt "," MInt ")" [function, klabel(one)]
  syntax MInt ::= "convertPV" "(" MInt ")" [function, klabel(one)]
endmodule

module TEST
    imports TEST-SYNTAX

    configuration <k>$PGM:Tasks</k>

    rule T:Task Ts:Tasks => T ~> Ts


    rule  getMemLoc(ptr(L:Int, MI:MInt)) => L
    rule getMIntVal(ptr(L:Int, MI:MInt)) => MI


  rule concatenateMInt(PV:PointerVal, MI:MInt) => ptr( getMemLoc(PV), concatenateMInt(convertPV(PV), convertPV(MI)))
  rule concatenateMInt(MI:MInt, PV:PointerVal) => ptr( getMemLoc(PV), concatenateMInt(convertPV(MI), convertPV(PV)))

  //rule concatenatePV(PV:PointerVal, MI:MInt) => concatenatePV(getMIntVal(PV), MI)
  //rule concatenatePV(MI:MInt, PV:PointerVal) => concatenatePV(getMIntVal(PV), MI)
  rule convertPV(PV:PointerVal) => getMIntVal(PV)
  rule convertPV(MI:MInt) => MI  [owise]

    //ptr(getMemLoc(PV), concatenateMInt(getMIntVal(PV), MI2)) 
    //concatenateMInt(getMIntVal(PV), MI2) 
    //ptr(getMemLoc(PV), concatenateMInt(MI1, getMIntVal(PV))) 
    //concatenateMInt(MI1, getMIntVal(PV))
 // rule concatenateMInt(ptr(L:Int, MI1:MInt), ptr(L:Int, MI2:MInt)) => 
 //   ptr(L, concatenateMInt(MI1, MI2)) 

  //rule ptr(I:Int, ptr(I:Int, MI:MInt)) => ptr(I, MI)
    
  rule test(I) => 
  concatenateMInt( 
    concatenateMInt(
      concatenateMInt(
        concatenateMInt(
          concatenateMInt(
            concatenateMInt(
              concatenateMInt(
                (ptr(1, mi(64, 0))),   
                (ptr(1, mi(64, 0)))),
                (ptr(1, mi(64, 0)))), 
                (ptr(1, mi(64, 0)))),
                (ptr(1, mi(64, 0)) )),
                (ptr(1, mi(64, 0)) )),
                (ptr(1, mi(64, 0)) )),
                (ptr(1, mi(64, 1)) ))
endmodule
