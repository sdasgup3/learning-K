requires "domains.k"

module TEST1-SYNTAX
    imports DOMAINS-SYNTAX

    syntax Task ::=  "convert" "(" String "," Int ")" [function]
    syntax Tasks ::= List{Task, ""}
endmodule

module TEST1
    imports TEST1-SYNTAX
    imports MINT

    configuration <k>$PGM:Tasks</k>

    rule T:Task Ts:Tasks => T ~> Ts

    syntax Int ::= HexStringtToInt(String, Int)  [function, hook(STRING.string2base)]
    rule convert(S:String, I:Int) => mi(String2Base(S, 16), 64)

endmodule
