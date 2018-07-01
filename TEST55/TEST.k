// HexConstant
// Macro
module TEST-SYNTAX
    imports DOMAINS-SYNTAX
    imports MINT

    syntax Task ::=  "div" "(" MInt "," MInt ")" [function]
    syntax Tasks ::= List{Task, ""}
endmodule

module TEST
    imports TEST-SYNTAX

    configuration <k>$PGM:Tasks</k>

    rule T:Task Ts:Tasks => T ~> Ts

    rule div(MI1, MI2) => extractMInt(
        udivMInt(
          MI1, 
          concatenateMInt(mi(bitwidthMInt(MI1) -Int bitwidthMInt(MI2), 0), MI2)),
        bitwidthMInt(MI2), bitwidthMInt(MI1))
    
endmodule
