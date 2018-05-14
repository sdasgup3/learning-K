requires "domains.k"

module TEST9-SYNTAX
    imports MINT

    syntax Comment ::= "comment" [token]

    syntax Task ::=  "add" "(" Int "," Int ")" [function]
                  | Comment
                  | Int
    syntax Tasks ::= List{Task, ""}
endmodule

module  TEST9
    imports TEST9-SYNTAX

    configuration <k>$PGM:Tasks</k>

    rule T:Task Ts:Tasks => T ~> Ts
    rule <k> comment   => . ...</k> // Rule 1
    rule add(W:Int, I:Int) => W +Int I
endmodule
