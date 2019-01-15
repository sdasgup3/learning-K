require "float-conversions.k"
module TEST-SYNTAX
    imports DOMAINS-SYNTAX
    imports MINT
    imports FLOAT

    syntax Task ::=  "test" "(" MInt "," MInt ")" [function]
    syntax Tasks ::= List{Task, ""}
    syntax Task ::= MInt
endmodule

module TEST
    imports TEST-SYNTAX
    imports FLOAT-CONVERSIONS

    configuration <k>$PGM:Tasks</k>

    rule T:Task Ts:Tasks => T ~> Ts

     syntax MInt ::= UIFBinOperation "(" MInt "," MInt ")"       [function]

     syntax UIFBinOperation ::= "add_single"                    [token]
                      | "div_single"                    [token]

    rule add_single(MI1:MInt, MI2:MInt) => Float2MInt(MInt2Float(MI1, 24, 8) +Float MInt2Float(MI2, 24, 8), 32)
    rule div_single(MI1:MInt, MI2:MInt) => Float2MInt(MInt2Float(MI1, 24, 8) /Float MInt2Float(MI2, 24, 8), 32)

    rule test(I:MInt, J:MInt) => div_single(I, J)
    
endmodule
