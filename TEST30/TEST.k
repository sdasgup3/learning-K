requires "domains.k"

// Error on recursion with #if $else

module TEST30-SYNTAX
    imports MINT
    //see what happens when u have function at List
    syntax Task ::=  "addcount" "(" Int")" 
    syntax Tasks ::= List{Task, ""} [klabel(tasklist)]

endmodule

module TEST30
    imports TEST30-SYNTAX

    configuration <k>$PGM:Tasks</k>

    rule T:Task Ts:Tasks => T ~> Ts

    syntax Int ::= countOnes(Int, Int)

    rule <k> addcount(N:Int) => countOnes(N, 0)
    ...</k>

    rule countOnes(I:Int, C:Int) => #if I ==Int 0 #then C #else countOnes(I -Int 1, C +Int 1) #fi
                                        
endmodule
