
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
    rule extractValue(RSMap)  =>  (#if zeroMInt(RSMap["AB"]:>MInt) #then mi(64,100) #else mi(64,200) #fi):>MInt

    syntax KItem ::= intermediate(MInt)

    rule <k> task => intermediate(extractValue(RSMap))
    ...</k>
        <state>  RSMap </state>

    rule 
      <k> intermediate(MI) => zeroMInt(MI)
      ...</k>




endmodule
