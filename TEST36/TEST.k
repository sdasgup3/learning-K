requires "domains.k"

// kprove runtime


module TEST36-SYNTAX
  imports DOMAINS-SYNTAX
  imports MINT
    syntax Task ::= "maintask" 
                    | "task" "(" MInt "," MInt ")"
                    | "test" "(" MInt  "," Int ")" [function]
    syntax Tasks ::= List{Task, ""} [klabel(tasklist)]

endmodule

module TEST36
    imports TEST36-SYNTAX
      imports DOMAINS



    configuration 
    <T>
    <k>$PGM:Tasks</k>
    <state> 
      ("RAX" |->    mi(64,  0 :Int))
      ("CF" |->     mi(1,   1 :Int))
    </state>
    </T>


    syntax MInt ::= "#ifMInt" Bool "#then" MInt "#else" MInt "#fi" [function, smtlib(ite)]
    syntax Bool ::= "#ifBool"   Bool "#then" Bool  "#else" Bool  "#fi" [function, smtlib(ite)]
    rule #ifMInt B #then W #else _ #fi => W requires B
    rule #ifMInt B #then _ #else W #fi => W requires notBool B
    rule #ifBool B #then W #else _ #fi => W requires B
    rule #ifBool B #then _ #else W #fi => W requires notBool B

    rule T:Task Ts:Tasks => T ~> Ts

    syntax MInt ::= getFlag(String, Map) [function]
    syntax KItem ::= "setRegisterValue"
    syntax MInt ::= "undef"
    syntax MInt ::= getSignBit(MInt) [function]
    syntax Bool ::= toBool(MInt) [function]
    syntax MInt ::= fromBool(Bool, Int) [function]
    syntax KItem ::= setFlag(MInt, String)
    syntax MInt ::= shiftLeft(MInt, Int)   [function]


    rule shiftLeft(MI, I) => 
      extractMInt(shlMInt(MI, I), 0, bitwidthMInt(MI))



    rule getFlag(FName, RSMap) => {RSMap[FName]}:>MInt 

    rule <k> setFlag(MI, FL) => . ...</k>
      <state>  
        RMap => RMap[FL <- MI] 
      </state>  

    rule getSignBit(MI:MInt) => 
    fromBool( toBool(
        andMInt(MI, 
            mi(bitwidthMInt(MI), sminMInt(bitwidthMInt(MI)))
        )
      ), 1)

     rule toBool(MI) => #ifBool uvalueMInt(MI) =/=Int 0 
                      #then true 
                      #else false 
                     #fi

      rule fromBool(B:Bool, W:Int) => #ifMInt B 
                                    #then mi(W,1) 
                                    #else mi(W,0) 
                                  #fi


    rule <k> maintask => task(getFlag("RAX", RSMap), andMInt(getFlag("RAX", RSMap), mi(64, 31)))
    ...</k>
      <state> RSMap </state>


    rule <k> task(MIsrc, MIcount) => 
     setFlag(
      (#ifMInt zeroMInt(MIcount)
      #then
        getFlag("CF", RSMap)
      #else
        (#ifMInt eqMInt(MIcount, mi(bitwidthMInt(MIcount),1))
        #then
          //xorMInt(getSignBit(MIsrc), getSignBit(shiftLeft(MIsrc, 1)))
          xorMInt(getSignBit(MIsrc), getSignBit(shlMInt(MIsrc, 1)))
        #else
          undef
        #fi)
      #fi)
        , 
        "CF")
    ...</k>
    <state> RSMap </state> 

    rule test(MI:MInt, I:Int) => shlMInt(MI, I)


endmodule

