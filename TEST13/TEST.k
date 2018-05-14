requires "domains.k"

module TEST13-SYNTAX
    imports MINT
    imports FLOAT

    syntax Task ::=  "pF" "(" Float ")" [function]
                  | "eF" "(" Float ")" [function]
                  | "eBF" "(" Float ")" [function]
                  | "sF" "(" Float ")" [function]
    syntax Tasks ::= List{Task, ""} [klabel(tasklist)]
endmodule

module  TEST13
    imports TEST13-SYNTAX

    configuration <k>$PGM:Tasks</k>

    rule T:Task Ts:Tasks => T ~> Ts

    rule  pF(F:Float) => precisionFloat(F)
    rule  eF(F:Float) => exponentFloat(F)
    rule  eBF(F:Float) => exponentBitsFloat(F)
    rule  sF(F:Float) => significandFloat(F)
endmodule
