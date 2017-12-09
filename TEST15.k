requires "domains.k"

module TEST15-SYNTAX
    imports MINT
    syntax Task ::=  "m2f" "(" Int "," Int ")" [function]
                  | "f2m"  "(" Float ")" [function]

    syntax Tasks ::= List{Task, ""} 
endmodule

module TEST15
    imports TEST15-SYNTAX
    imports FLOAT

    configuration <k>$PGM:Tasks</k>

    rule T:Task Ts:Tasks => T ~> Ts
    
    syntax KItem ::=  temp(Int, MInt)
    rule m2f(I,W) => MInt2Float(mi(W,I), 24,8 )
    rule f2m(F) => temp(exponentFloat(F), significandFloat(F))

endmodule
