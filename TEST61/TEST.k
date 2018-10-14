// HexConstant
// Macro
module TEST-SYNTAX
    imports DOMAINS-SYNTAX
    imports MINT

    syntax Task ::=  "testMacro" "(" Int "," Int ")" [function]
    syntax Task ::=  MInt
    syntax Tasks ::= List{Task, ""}
endmodule

module TEST
    imports TEST-SYNTAX

    configuration <k>$PGM:Tasks</k>

    rule T:Task Ts:Tasks => T ~> Ts

    rule testMacro(I, J) => mi(64, 0)
    
endmodule
