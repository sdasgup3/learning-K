requires "domains.k"

module TEST8-SYNTAX
    imports MINT
    //see what happens when u have function at List
    syntax Task ::=  "task1" "(" Int "," Int ")" [function]
                  |  "task2" "(" Int "," Int ")"  [function]
                  | "testExtractMInt" "(" Int "," Int ")"
    syntax Tasks ::= List{Task, ""} [klabel(tasklist)]

    /*
    syntax MInt ::= intermed(MInt) [function]
    syntax MInt ::= countOnes(MInt, Int) [function]
    syntax KItem ::= exec(MInt)
    */
endmodule

module TEST8
    imports TEST8-SYNTAX

    configuration <k>$PGM:Tasks</k>

    rule T:Task Ts:Tasks => T ~> Ts
    
    rule task1(I,W) => extractMInt(shlMInt(mi(W, I), 1), 0, W )
    rule task2(I,W) => shlMInt(mi(W, I), 1)

endmodule
