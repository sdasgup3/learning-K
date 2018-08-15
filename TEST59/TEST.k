require "domains.k"


module TEST-SYNTAX
    imports FLOAT
    imports MINT

    syntax HexConstant ::=  r"0x[0-9a-fA-F]+" [token]
    syntax Task ::=  "test" "(" HexConstant "," Float  "," Int "," Int "," Int ")" [function]

    syntax Tasks ::= List{Task, ""} [klabel(tasklist)]
endmodule

module TEST
    imports TEST-SYNTAX
    imports DOMAINS

    configuration <k>$PGM:Tasks</k>

  syntax String ::= HexConstant2String ( HexConstant )    [function, hook(STRING.token2string)]
  syntax Int ::= HexConstant2Int ( HexConstant )    [function]
  rule HexConstant2Int(H:HexConstant) =>
    String2Base(substrString(HexConstant2String(H), 2, lengthString(HexConstant2String(H))), 16)

    
    rule T:Task Ts:Tasks => T ~> Ts
    //rule test(H, F,  W, P, E) =>  HexConstant2Int(H)
    rule test(H, F,  W, P, E) => eqMInt(mi(W, HexConstant2Int(H)), Float2MInt(MInt2Float(mi(W, HexConstant2Int(H)), P,E), W))
    
endmodule
