
module TEST29-SYNTAX
    imports MINT
    syntax Task ::=  "task"

    syntax Tasks ::= List{Task, ""} [klabel(tasklist)]

endmodule

module TEST29
    imports TEST29-SYNTAX

    configuration 
    <T>
      <k>$PGM:Tasks</k>
      <state> 
        "AB" |-> mi(64,0):MInt 
      </state>
    </T>

    rule T:Task Ts:Tasks => T ~> Ts

    syntax MInt ::= extractValue(Map) [function]

    /*
    rule extractValue(RSMap)  =>  mi(64,100)
      requires zeroMInt(RSMap["AB"]:>MInt) 
    
    rule extractValue(RSMap)  =>  mi(64,200)
      requires notBool zeroMInt(RSMap["AB"]:>MInt) 
    */


    syntax MInt ::= "#ifMInt" Bool "#then" MInt "#else" MInt "#fi" [function, smtlib(ite)]

    rule #ifMInt B #then W #else _ #fi => W requires B
    rule #ifMInt B #then _ #else W #fi => W requires notBool B

    rule extractValue(RSMap)  =>  #ifMInt zeroMInt(RSMap["AB"]:>MInt) #then mi(64,100) #else mi(64,200) #fi

    syntax KItem ::= intermediate(MInt)

    rule <k> task => intermediate(extractValue(RSMap))
    ...</k>
        <state>  RSMap </state>

    rule 
      <k> intermediate(MI) => .
      ...</k>
      <state>...
        "AB" |-> (MIold => addMInt(MIold, MI))
      ...</state>

endmodule
