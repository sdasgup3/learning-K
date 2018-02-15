requires "domains.k"
requires "verification-lemmas.k"

// verification lemmas

// Not Allowed:  <state>     "AB" |->   mi(64, I:Int):MInt

module TEST33-SYNTAX
    imports MINT
    syntax Task ::=  "task"
    syntax Tasks ::= List{Task, ""} [klabel(tasklist)]

endmodule

module TEST33
    imports TEST33-SYNTAX
    imports VERIFICATION-LEMMAS

    configuration 
    <T>
    <k>$PGM:Tasks</k>
    <state> 
      "AB" |-> mi(64, 10):MInt
      "CD" |-> mi(64, 1)
      "YMM" |-> mi(256, 10):MInt
      "F" |-> mi(1, 0)
      "CF" |-> mi(1, 0)

                       /*
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
      "BW15" |-> mi(64, 0):MInt
      "BW16" |-> mi(64, 0):MInt
      "BW17" |-> mi(64, 0):MInt
      */
    </state>
    </T>


    rule T:Task Ts:Tasks => T ~> Ts

    rule <k> task => . 
    ...</k>
      <state> ...
            //"AB" |->  (MI1 => addMInt(MI1, #parseToken("MInt@MINT","64'0"):>MInt))
            "AB" |->  (MI1 => addMInt(MI1, mi(64, 0)))
            "CD" |->  (MI2 => xorMInt(MI1, MI1))
            "YMM" |-> (MI256 => MI256)
            "CF" |-> (MICF => MICF)
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

            "BW14" |->  ( _ => bitwidthMInt((#ifMInt (eqMInt(andMInt(extractMask(MI1, 8, 0), mi(bitwidthMInt(extractMask(MI1, 8, 0)), 63)), mi(bitwidthMInt(andMInt(extractMask(MI1, 8, 0), mi(bitwidthMInt(extractMask(MI1, 8, 0)), 63))), 0)) ) #then ( (#ifMInt (eqMInt(MI1, mi(64, 1)) ) #then ( mi(8, -128) ) #else ( mi(8, 0) ) #fi) ) #else ( (#ifMInt (ultMInt(andMInt(extractMask(MI1, 8, 0), mi(bitwidthMInt(extractMask(MI1, 8, 0)), 63)), mi(bitwidthMInt(andMInt(extractMask(MI1, 8, 0), mi(bitwidthMInt(extractMask(MI1, 8, 0)), 63))), bitwidthMInt(MI1))) ) #then ( shlMInt(MI1, uvalueMInt(andMInt(extractMask(MI1, 8, 0), mi(bitwidthMInt(extractMask(MI1, 8, 0)), 63)))) ) #else ( mi(bitwidthMInt(MI1), 0) ) #fi)  ) #fi):>MInt ))

            "BW15" |-> ( MI15 => concatenateMInt(extractMInt(mi(64, uvalueMInt(extractMInt(MI1, 0, 32))), 32, 64), extractMInt(mi(64, uvalueMInt(extractMInt(MI1, 32, 64))), 32, 64)) )
            "BW16" |-> ( MI15 => concatenateMInt(
                  extractMInt(
                    concatenateMInt(mi(32, 0), extractMInt(MI1, 0, 32))
                    , 32, 64), 
                  extractMInt(
                    concatenateMInt(mi(32, 0), extractMInt(MI1, 32, 64))
                    , 32, 64)
                  ) )
            "BW17" |-> ( _ => extractMInt(concatenateMInt(mi(128, 0), extractMInt(MI256, 128, 256)), 64, 128))
            */
            "F" |-> (
                _ =>(extractMInt(addMInt(concatenateMInt(mi(1, 0), extractMInt(addMInt(concatenateMInt(mi(15, 0), MICF), mi(16, 65535)), 8, 16)), concatenateMInt(mi(1, 0), extractMInt(addMInt(concatenateMInt(mi(15, 0), MICF), mi(16, 65535)), 8, 16))), 0, 1) )
                )
      ...  </state>

endmodule

