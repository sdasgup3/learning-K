requires "domains.k"

module TEST7-SYNTAX
    imports MINT
    //see what happens when u have function at List
    syntax Task ::=  "popcount" "(" Int "," Int ")" 
    syntax Tasks ::= List{Task, ""} [function]

    /*
    syntax MInt ::= intermed(MInt) [function]
    syntax MInt ::= countOnes(MInt, Int) [function]
    syntax KItem ::= exec(MInt)
    */
endmodule

module TEST7
    imports TEST7-SYNTAX

    configuration <k>$PGM:Tasks</k>

    rule T:Task Ts:Tasks => T ~> Ts

    /*
    rule <k>popcount(N:Int, W:Int) => exec( intermed(mi(W,N))) ...</k>

    rule exec(MI:MInt) => MI

    rule intermed(MI:MInt) => countOnes(MI, 0)

    rule countOnes(MI:MInt, C:Int) => 
      countOnes(andMInt(MI, subMInt(MI, mi(bitwidthMInt(MI),1))), C +Int 1)
        requires notBool zeroMInt(MI)

    rule countOnes(MI:MInt, C:Int) => mi(bitwidthMInt(MI), C) 
      requires zeroMInt(MI)
      */

endmodule
