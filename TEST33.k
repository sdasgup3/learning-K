requires "domains.k"

// verification lemmas

// Not Allowed:  <state>     "AB" |->   mi(64, I:Int):MInt

module TEST33-SYNTAX
    imports MINT
    syntax Task ::=  "task"
    syntax Tasks ::= List{Task, ""} [klabel(tasklist)]

endmodule

module TEST33
    imports TEST33-SYNTAX

    configuration 
    <T>
    <k>$PGM:Tasks</k>
    <state> 
      "AB" |-> mi(64, 10):MInt
      "CD" |-> mi(64, 1)
      "EF" |-> mi(64, 2)
    </state>
    </T>


    rule T:Task Ts:Tasks => T ~> Ts
    syntax Int ::= "XX" 

    // rule addMInt(mi(64, I), #parseToken("MInt@MINT", "64'0"):>MInt) => mi(64, I)
    rule addMInt(mi(64, XX), mi(64, 0)) => mi(64, 0) [lemma]
    rule xorMInt(mi(W, I), mi(W, I)) => mi(W, 0)              [lemma]
    rule subMInt(mi(W, I), mi(W, I)) => mi(W, 0)              [lemma]
    rule bitwidthMInt(mi(W:Int, _:Int)) => W
    rule xorMInt(MI:MInt, MI:MInt) => mi(bitwidthMInt(MI), 0)              [lemma]


    rule <k> task => . 
    ...</k>
      <state> ...
            //"AB" |->  (MI1 => addMInt(MI1, #parseToken("MInt@MINT","64'0"):>MInt))
            "AB" |->  (MI1 => addMInt(MI1, mi(bitwidthMInt(MI1), 0)))
            "CD" |->  (MI2 => xorMInt(MI2, MI2))
            "EF" |->  (MI3 => subMInt(MI3, MI3))
            ...
      </state>

endmodule
