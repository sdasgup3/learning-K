requires "domains.k"

module TEST-SYNTAX
    imports MINT
    //see what happens when u have function at List
    syntax Task ::=  "task1" "(" Int "," Int ")" [function]
                  |  "task2" "(" Int "," Int ")"  [function]
                  |  "task3" "(" Int "," Int "," Int ")"  [function]
                  |  "task4" "(" Int "," Int "," Int ")"  [function]
                  |  "task5" "(" Int "," Int "," Int ")"  [function]
                  | "testExtractMInt" "(" Int "," Int ")"
    syntax Tasks ::= List{Task, ""} [klabel(tasklist)]

    /*
    syntax MInt ::= intermed(MInt) [function]
    syntax MInt ::= countOnes(MInt, Int) [function]
    syntax KItem ::= exec(MInt)
    */
endmodule

module TEST
    imports TEST-SYNTAX

    configuration <k>$PGM:Tasks</k>

    rule T:Task Ts:Tasks => T ~> Ts
    
    rule task1(I,W) => extractMInt(shlMInt(mi(W, I), 1), 0, W )
    rule task2(I,W) => shlMInt(mi(W, I), 1)

    rule task3(I, J, K) => extractMInt(shlMInt(mi(I, J), K), 0, I)
    rule task4(I, J, K) => shlMInt(mi(I, J), K)

    rule task5(I, J, K) => lshrMInt(mi(I, J), K)
endmodule
