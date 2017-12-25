
module TEST23-SYNTAX
    imports MINT
    syntax Task ::=  "test" "(" Int "," Int ")" 
                | "show" "(" Int ")"
    syntax Tasks ::= List{Task, ""} [klabel(tasklist)]

endmodule

module TEST23
    imports TEST23-SYNTAX

    configuration 
    <T>
      <k>$PGM:Tasks</k>
      <mem> .Map </mem>
    </T>

    rule T:Task Ts:Tasks => T ~> Ts

    syntax MInt ::= getFlag(Int, Map) [function]
    rule getFlag(I, XM) => XM[I]:>Int

    rule <k>
      test (I,J) => .
    ...</k>
      <mem>... .Map => (I |-> J) ...</mem>
    
    rule <k>
      show(I) => getFlag(I,XM)
    ...</k>
      <mem> XM </mem>


endmodule
