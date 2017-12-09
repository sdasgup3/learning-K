requires "domains.k"

module TEST5-SYNTAX
    imports MINT

    syntax Comment ::=  ";" r"[^\n]*[\n]" [lableOnly, token, autoReject] //1

    syntax Task ::=  "add" "(" Int "," Int ")" [function]
                  | Comment //1
     syntax Tasks ::= List{Task, ""}
endmodule

module TEST5
    imports TEST5-SYNTAX

    configuration <k>$PGM:Tasks</k>

    rule T:Task Ts:Tasks => T ~> Ts
    rule <k>C:Comment => . ...</k> //1

    rule add(W:Int, I:Int) => W +Int I
endmodule
