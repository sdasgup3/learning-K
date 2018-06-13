requires "domains.k"

module TEST-SYNTAX
    imports MINT
    syntax Task ::=  "task1" "(" MInt "," Int ")" [function]
                  |  "task2" "(" MInt "," Int ")"  [function]
      //            |  "task3" "(" MInt "," Int ")"  [function]
    syntax Tasks ::= List{Task, ""} [klabel(tasklist)]
endmodule

module TEST
    imports TEST-SYNTAX

    configuration <k>$PGM:Tasks</k>

    rule T:Task Ts:Tasks => T ~> Ts
    
    rule task1(MI:MInt, C:Int) => extractMInt(shlMInt(MI, C), 0, bitwidthMInt(MI) )
    rule task2(MI:MInt, C:Int) => shlMInt(MI, C)
    //rule task3(MI:MInt, C:Int) => andMInt(shlMInt(MI, C), mi(bitwidthMInt(MI), -1) )
endmodule
