requires "domains.k"

module TEST11-SYNTAX
    imports MINT

    syntax Opcode::= "add" [token]
                  | "sub" 
    syntax Task ::= execute(Opcode)
                  | "compute" "(" Opcode ")"
    syntax Tasks ::= List{Task, ""} [klabel(tasklist)]
endmodule

module  TEST11
    imports TEST11-SYNTAX

    configuration <k>$PGM:Tasks</k>

    rule T:Task Ts:Tasks => T ~> Ts

    rule <k>execute(add)  => . ...</k>
    rule <k>execute(sub) => . ...</k>
    rule <k>compute(add) => . ...</k>
    rule <k>compute(sub) => . ...</k>
endmodule
