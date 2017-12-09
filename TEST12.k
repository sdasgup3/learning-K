requires "domains.k"

module TEST12-SYNTAX
    imports MINT

    syntax Task ::=  "add" [token]
                  | "sub" [token]
    syntax Tasks ::= List{Task, ""} [klabel(tasklist)]
endmodule

module  TEST12
    imports TEST12-SYNTAX

    configuration <k>$PGM:Tasks</k>

    rule T:Task Ts:Tasks => T ~> Ts

    rule <k>T:Task => . ...</k>
    rule <k>.Tasks => . ...</k>
endmodule
