// HexConstant
// Macro
module TEST-SYNTAX
    imports DOMAINS-SYNTAX
    imports MINT

    syntax Task ::=  "test" "("  Int ")" [function]
    syntax Task ::=  "test1" "("  MInt ")" [function]
    syntax Tasks ::= List{Task, ""}
endmodule

module TEST
    imports TEST-SYNTAX
    imports INT

    configuration <k>$PGM:Tasks</k>

    rule T:Task Ts:Tasks => T ~> Ts

    rule test(I) => ~Int I
    rule test1(MI:MInt) => addMInt(negMInt(MI:MInt), mi(32, 1))
    
endmodule
