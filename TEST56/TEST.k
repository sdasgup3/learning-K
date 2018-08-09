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
    
    syntax MInt ::= "#ifMInt"   Bool "#then" MInt  "#else" MInt  "#fi" [function]
    rule #ifMInt B #then W #else _ #fi => W requires B
    rule #ifMInt B #then _ #else W #fi => W requires notBool B

    syntax MInt ::= "undef" [function]
    rule undef => mi(64, 1)

    rule task(I:Int) => #ifMInt eqMInt(undef,  mi(64, 0)) #then mi(64, 0) #else  mi(64,1) #fi
endmodule
