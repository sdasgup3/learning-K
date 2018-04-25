requires "domains.k"

module TEST14-SYNTAX
    imports MINT
    syntax Task ::=  "testUExtractMInt" "(" Int "," Int ")" [function]
                  | "testLExtractMInt" "(" Int "," Int ")" [function]
                  | "testS" "(" Int "," Int ")" [function]
    syntax Tasks ::= List{Task, ""} [function]
endmodule

module TEST14
    imports TEST14-SYNTAX

    configuration <k>$PGM:Tasks</k>

    rule T:Task Ts:Tasks => T ~> Ts
    
    rule testUExtractMInt(I,W) => extractMInt(mi(W,I), 0,4 )
    rule testLExtractMInt(I,W) => extractMInt(mi(W,I), 4,8 )
    rule testS(I,W) => extractMInt(mi(W,I), 0,1 )

endmodule
