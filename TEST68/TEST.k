require "float-conversions.k"
module TEST-SYNTAX
    imports DOMAINS-SYNTAX
    imports MINT
    imports FLOAT

    syntax Task ::=  "test" "(" MInt "," Int ")" [function]
    syntax Tasks ::= List{Task, ""}
    syntax Task ::= MInt
endmodule

module TEST
    imports TEST-SYNTAX
    imports FLOAT-CONVERSIONS

    configuration <k>$PGM:Tasks</k>

    rule T:Task Ts:Tasks => T ~> Ts

    rule test(I:MInt, J:Int) => extractMInt(shlMInt(I, J), 0, 4)
    
endmodule
