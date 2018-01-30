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
      "CD2" |-> mi(64, 1)
      "EF" |-> mi(64, 2)
      "GH" |-> ?B:Bool

      "BW1" |-> ?I:Int
      "BW2" |-> ?I:Int
      "BW3" |-> ?I:Int
      "BW4" |-> ?I:Int
      "BW5" |-> ?I:Int
      "BW6" |-> ?I:Int
      "BW7" |-> ?I:Int
      "BW8" |-> ?MI:MInt
      "BW9" |-> ?I:Int
      "BW10" |-> ?I:Int
      "BW11" |-> ?I:Int
      "BW12" |-> ?MI1:MInt
      "BW13" |-> ?MI1:MInt
      "BW14" |-> 0:Int
    </state>
    </T>


    rule T:Task Ts:Tasks => T ~> Ts
    syntax Int ::= "XX" 

    syntax MInt ::= "#ifMInt" Bool "#then" MInt "#else" MInt "#fi" [function, smtlib(ite)]
    rule #ifMInt B #then W #else _ #fi => W requires B
    rule #ifMInt B #then _ #else W #fi => W requires notBool B

    syntax MInt ::= extractMask(MInt, Int, Int) [function]
 rule extractMask(MI, NUM, P) => extractMInt(MI, bitwidthMInt(MI) -Int P -Int NUM, 
      bitwidthMInt(MI) -Int P)
    requires (P +Int NUM) <=Int bitwidthMInt(MI)

   syntax MInt ::= zeroExtend(MInt, Int) [function]
rule zeroExtend(MI:MInt, N:Int) => mi(N, uvalueMInt(MI))
    requires N >=Int bitwidthMInt(MI)




    // rule addMInt(mi(64, I), #parseToken("MInt@MINT", "64'0"):>MInt) => mi(64, I)
    //rule addMInt(mi(64, XX), mi(64, 0)) => mi(64, 0) [lemma]
    rule addMInt(_:MInt, MI) => mi(64, 0)
      requires eqMInt(MI, mi(64,0))



    rule xorMInt(mi(W, I), mi(W, I)) => mi(W, 0)              [lemma]

    rule subMInt(mi(W, I), mi(W, I)) => mi(W, 0)              [lemma]
    rule xorMInt(MI:MInt, MI:MInt) => mi(bitwidthMInt(MI), 0)              [lemma]

    rule ultMInt(_:MInt, MI) =>  false   
     requires eqMInt(MI, mi(64,0))

    // Note that cocrete mi(64, 43) is matched with MIC and symbolic MI is matched with mi(W, I) 
    rule bitwidthMInt(mi(W:Int, _:Int)) => W      [lemma]    // BW1

    /*
    rule bitwidthMInt(addMInt(mi(W, _), _)) => W    [lemma]  // BW3 BW5 BW6 BW11
    rule bitwidthMInt(addMInt(_, mi(W, _))) => W    [lemma]  // BW10
    rule bitwidthMInt(addMInt(MIC, _)) => bitwidthMInt(MIC)   [lemma]         // BW4 BW7 BW8
    rule bitwidthMInt(addMInt(_, MIC)) => bitwidthMInt(MIC)   [lemma]         // BW9
    */

    rule bitwidthMInt(addMInt(mi(W, _), _)) => W    [lemma]  // BW3 BW5 BW6 BW11
    rule bitwidthMInt(addMInt(extractMInt(_,_,_), mi(W,_))) => W    [lemma]  // BW10
    rule bitwidthMInt(addMInt(extractMInt(_,_,_), MIC)) => bitwidthMInt(MIC)    [lemma]  // BW9

    rule bitwidthMInt(addMInt(MIC, _)) => bitwidthMInt(MIC)   [lemma]         // BW4 BW7 BW8

    rule bitwidthMInt(extractMInt(MI:MInt, S:Int, E:Int)) => E -Int S [lemma]
    rule bitwidthMInt(xorMInt(mi(W, _), _)) => W [lemma]
    rule bitwidthMInt(#ifMInt B:Bool #then MI1 #else MI2 #fi) => bitwidthMInt(MI1) [lemma]

    rule <k> task => . 
    ...</k>
      <state> ...
            //"AB" |->  (MI1 => addMInt(MI1, #parseToken("MInt@MINT","64'0"):>MInt))
            "AB" |->  (MI1 => addMInt(MI1, mi(64, 0)))
            "CD" |->  (MI2 => xorMInt(MI1, MI1))
            /*
            "CD2" |->  (MI3 => xorMInt(addMInt(MI1, MI1), addMInt(MI1, MI1)))
            "EF" |->  (MI4 => subMInt(MI1, MI1))
            "GH" |->  (_ => ultMInt(addMInt(MI1, MI1), mi(64, 0)))

            // bitwidthMInt
            "BW1" |->  (_ => bitwidthMInt(MI1) )
            "BW2" |->  (_ => bitwidthMInt(mi(8, 5)) )
            "BW3" |->  (_ => bitwidthMInt(addMInt(MI1, MI1)) )
            "BW4" |->  (_ => bitwidthMInt(addMInt(mi(64, 43), MI1)) )
            "BW5" |->  (_ => bitwidthMInt(addMInt(MI1, mi(64, 43))) )
            "BW6" |->  (_ => bitwidthMInt(addMInt(MI1, MI1)) )
            "BW7" |->  (_ => bitwidthMInt(addMInt(mi(8, 255), extractMInt(MI1, 56, 64))))
            "BW8" |->  (_ => #ifMInt (eqMInt(mi(bitwidthMInt(addMInt(mi(8, 255), extractMInt(MI1, 56, 64))), 1), lshrMInt(addMInt(mi(8, 255), extractMInt(MI1, 56, 64)),  ( bitwidthMInt(addMInt(mi(8, 255), extractMInt(MI1, 56, 64)))  -Int  1 ) )) ) #then ( mi(1, 1) ) #else ( mi(1, 0) ) #fi  )
            "BW9" |->  (_ => bitwidthMInt(addMInt(extractMInt(MI1, 56, 64), mi(8, 255))))
            "BW10" |->  (_ => bitwidthMInt(addMInt(extractMInt(MI1, 0, 64), MI1)))
            "BW11" |->  (_ => bitwidthMInt(addMInt(MI1, extractMInt(MI1, 0, 64))))
            "BW12" |->  ( _ => (#ifMInt (eqMInt(mi(bitwidthMInt(extractMask(MI1, 16, 0)), 2), addMInt(xorMInt(lshrMInt(extractMask(MI1, 16, 0),  ( bitwidthMInt(extractMask(MI1, 16, 0))  -Int  1 ) ), lshrMInt(addMInt(addMInt(extractMask(MI1, 16, 0), extractMask(MI1, 16, 0)), zeroExtend(MI1, 16)),  ( bitwidthMInt(extractMask(MI1, 16, 0))  -Int  1 ) )), xorMInt(lshrMInt(extractMask(MI1, 16, 0),  ( bitwidthMInt(extractMask(MI1, 16, 0))  -Int  1 ) ), lshrMInt(addMInt(addMInt(extractMask(MI1, 16, 0), extractMask(MI1, 16, 0)), zeroExtend(MI1, 16)),  ( bitwidthMInt(extractMask(MI1, 16, 0))  -Int  1 ) )))) ) #then ( mi(1, 1) ) #else ( mi(1, 0) ) #fi)  )
            "BW13" |->  ( _ => mi(bitwidthMInt(xorMInt(MI1, orMInt(MI1, MI1))), 0) )
            */

            "BW14" |->  ( _ => bitwidthMInt((#ifMInt (eqMInt(andMInt(extractMask(MI1, 8, 0), mi(bitwidthMInt(extractMask(MI1, 8, 0)), 63)), mi(bitwidthMInt(andMInt(extractMask(MI1, 8, 0), mi(bitwidthMInt(extractMask(MI1, 8, 0)), 63))), 0)) ) #then ( (#ifMInt (eqMInt(MI1, mi(64, 1)) ) #then ( mi(8, -128) ) #else ( mi(8, 0) ) #fi) ) #else ( (#ifMInt (ultMInt(andMInt(extractMask(MI1, 8, 0), mi(bitwidthMInt(extractMask(MI1, 8, 0)), 63)), mi(bitwidthMInt(andMInt(extractMask(MI1, 8, 0), mi(bitwidthMInt(extractMask(MI1, 8, 0)), 63))), bitwidthMInt(MI1))) ) #then ( shlMInt(MI1, uvalueMInt(andMInt(extractMask(MI1, 8, 0), mi(bitwidthMInt(extractMask(MI1, 8, 0)), 63)))) ) #else ( mi(bitwidthMInt(MI1), 0) ) #fi)  ) #fi):>MInt ))
      ...  </state>

endmodule

