requires "domains.k"

module TEST4-SYNTAX
    imports MINT

    syntax Comment ::= ";" r"[^\n]*[\n]" [lableOnly, token, autoReject]

    syntax Task ::=  "add" "(" Int "," Int ")" 
                  | Comment
    syntax Tasks ::= List{Task, ""}
endmodule

module TEST4
    imports TEST4-SYNTAX

    configuration <k>$PGM:Tasks</k>
    rule T:Task Ts:Tasks => T ~> Ts

    // Following 2 rules are the same.
    rule <k> Cmnt:Comment R:Tasks  => R ...</k> // Rule 1
    //rule <k> Cmnt:Comment   => . ...</k> // Rule 1
    rule add(W:Int, I:Int) => W +Int I
endmodule
