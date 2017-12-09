requires "domains.k"

module TEST3-SYNTAX
    imports MINT

    syntax Comment ::= "comment" [token]

    syntax Task ::=  "add" "(" Int "," Int ")" 
                  | Comment
    syntax Tasks ::= List{Task, ""}
endmodule

module TEST3
    imports TEST3-SYNTAX

    configuration <k>$PGM:Tasks</k>

    rule T:Task Ts:Tasks => T ~> Ts

    rule <k> comment   => . ...</k> // Rule 1
    rule add(W:Int, I:Int) => W +Int I
endmodule
