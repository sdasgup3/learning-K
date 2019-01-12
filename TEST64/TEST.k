// Copyright (c) 2018 K Team. All Rights Reserved.
module TEST-SYNTAX
    //imports DOMAINS-SYNTAX This need to be comented to allow Infiinity to not to be regarded aa an ID
    imports FLOAT-SYNTAX
    imports MINT
    imports FLOAT

    syntax Task ::=  "test" "(" Int "," Float  "," Int "," Int "," Int ")" [function]
    syntax Tasks ::= List{Task, ""}
    syntax Task ::= Float
endmodule

module TEST
    imports TEST-SYNTAX

    configuration <k>$PGM:Tasks</k>

    rule T:Task Ts:Tasks => T ~> Ts
    rule test(I, F,  W, P, E) => F

endmodule
