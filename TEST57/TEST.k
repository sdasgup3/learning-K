// HexConstant
// Macro
module TEST-SYNTAX
    imports DOMAINS-SYNTAX
    imports MINT

    syntax Task ::=  "task" "(" Int  ")" [function]
    syntax Tasks ::= List{Task, ""}
endmodule

module TEST
    imports TEST-SYNTAX

    configuration <k>$PGM:Tasks</k>

    rule T:Task Ts:Tasks => T ~> Ts
    
    rule task(I:Int) => uremMInt(mi(16, I), mi(16, 1))
endmodule
