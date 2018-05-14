// Copyright (c) 2016 K Team. All Rights Reserved.
requires "domains.k"

module TEST39-SYNTAX
    imports MINT
    imports FLOAT
    imports DOMAINS-SYNTAX


    syntax Task ::=  "test" "(" Int "," Float  "," Int "," Int "," Int ")" [function]
                  | "task" [function]
    syntax Tasks ::= List{Task, ""}
endmodule

module TEST39
    imports TEST39-SYNTAX
    imports DOMAINS



    configuration <k>$PGM:Tasks</k>

    rule T:Task Ts:Tasks => T ~> Ts
    rule test(I, F,  W, P, E) =>  eqMInt(mi(W, I), Float2MInt(MInt2Float(mi(W,I), P,E), W))
                                andBool F ==Float MInt2Float(Float2MInt(F,W), P, E)
                                andBool MInt2Float(mi(W,I), P,E) ==Float F
                                andBool eqMInt(Float2MInt(F,W), mi(W,I))

    syntax MInt ::= "add_double" "(" MInt ")" [function]

    rule task => addMInt(mi(3, 3), add_double(mi(3,3)))
endmodule
