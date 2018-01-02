requires "domains.k"

module TEST7-SYNTAX
    imports MINT
    //see what happens when u have function at List
    syntax Task ::=  "popcount" "(" Int "," Int ")" 
    syntax Tasks ::= List{Task, ""} [function]

endmodule

module TEST7
    imports TEST7-SYNTAX

    configuration <k>$PGM:Tasks</k>

    rule T:Task Ts:Tasks => T ~> Ts

    syntax MInt ::= countOnes(MInt, Int) [function]

    rule <k> popcount(N:Int, W:Int) => countOnes(mi(W,N), 0)
    ...</k>

    rule countOnes(MI:MInt, C:Int) => #if zeroMInt(MI) #then
                                        mi(bitwidthMInt(MI), C) 
                                      #else
                                        countOnes(andMInt(MI, subMInt(MI, mi(bitwidthMInt(MI),1))), C +Int 1)
                                      #fi
                                        
endmodule
