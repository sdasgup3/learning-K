// Rotate left right
module TEST-SYNTAX
    imports MINT
    imports INT

    syntax Task ::= "task1" "(" MInt ")" [function]

    syntax Tasks ::= List{Task, ""}

endmodule

module TEST
    imports TEST-SYNTAX

    configuration 
      <k> $PGM:Tasks </k>

    rule  task1(MI:MInt) => eqMInt(rol(MI, mi(bitwidthMInt(MI), bitwidthMInt(MI))), MI) 
      andBool eqMInt(ror(MI, mi(bitwidthMInt(MI), bitwidthMInt(MI))), MI)

    rule <k> T:Task Ts:Tasks => T ~> Ts 
    ...</k>

    
    syntax MInt ::= shiftLeftMInt(MInt, Int) [function]
    rule shiftLeftMInt(MI, I) => 
    extractMInt(shlMInt(MI, I), 0, bitwidthMInt(MI))



    syntax MInt ::= rol(MInt, MInt) [function]
    syntax MInt ::= rolHelper(MInt, Int, Int) [function]

    syntax MInt ::= ror(MInt, MInt) [function]
    syntax MInt ::= rorHelper(MInt, Int, Int) [function]

    rule rol(MI1:MInt, MI2:MInt) => rolHelper(MI1, uvalueMInt(MI2),  0)
    rule ror(MI1:MInt, MI2:MInt) => rorHelper(MI1, uvalueMInt(MI2),  0)

    rule rolHelper(MI:MInt, N:Int, N:Int) => MI
    rule rolHelper(MI:MInt, N:Int, M:Int) =>
      rolHelper(
        addMInt( 
          shiftLeftMInt(MI, 1), 
          concatenateMInt(
            mi(bitwidthMInt(MI) -Int 1, 0), 
            extractMInt(MI, 0, 1)
          )
        ), N, M +Int 1)  
    requires M <Int N


    rule rorHelper(MI:MInt, N:Int, N:Int) => MI
    rule rorHelper(MI:MInt, N:Int, M:Int) =>
      rorHelper(
        addMInt( 
          lshrMInt(MI, 1), 
          concatenateMInt(
            extractMInt(MI, bitwidthMInt(MI) -Int 1, bitwidthMInt(MI)),
            mi(bitwidthMInt(MI) -Int 1, 0) 
          )
        ), N, M +Int 1)  
    requires M <Int N


    

endmodule
