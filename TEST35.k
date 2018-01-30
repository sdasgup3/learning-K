requires "domains.k"

// kprove runtime


module TEST35-SYNTAX
    imports MINT
    syntax Task ::=  "task"
    syntax Tasks ::= List{Task, ""} [klabel(tasklist)]

endmodule

module TEST35
    imports TEST35-SYNTAX

    configuration 
    <T>
    <k>$PGM:Tasks</k>
    <state> 
      ("RAX" |->    mi(64,  0 :Int))
      ("CF" |->     mi(1,   1 :Int))
    </state>
    </T>


    rule T:Task Ts:Tasks => T ~> Ts

    syntax MInt ::= getFlag(String, Map) [function]
    syntax KItem ::= "setRegisterValue"

    rule getFlag(FName, RSMap) => RSMap[FName]:>MInt 


    rule <k> task => #if zeroMInt(getFlag("CF", RSMap)) #then . #else setRegisterValue  #fi
    ...</k>
    <state> RSMap </state> 
      /*
      requires zeroMInt(getFlag("CF", RSMap))

    rule <k> 
      task => setRegisterValue
    ...</k>
    <state> RSMap </state>
      requires notBool zeroMInt(getFlag("CF", RSMap))
      */

    rule <k> 
      setRegisterValue => .
    ...</k>

endmodule

