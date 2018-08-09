require "domains.k"

module TEST-SYNTAX
    imports DOMAINS-SYNTAX

    syntax Task ::=  "task" 
    syntax Tasks ::= List{Task, ""} [klabel(tasklist)]
endmodule

module TEST
    imports TEST-SYNTAX
    imports DOMAINS
    imports MINT

    configuration 
    <T>
      <k>$PGM:Tasks</k>
      <state> 
        "AB" |-> mi(64, 10):MInt
      </state>
    </T>          

     /*@
    L8: extract(MI) short width
    */
  rule extractMInt(MI:MInt, S:Int, E:Int) => mi(E -Int S, uvalueMInt(MI))
    requires  bitwidthMInt(MI) ==Int E
    andBool   E >Int S
    andBool   bitwidthMInt(MI) >Int (E -Int S)
    andBool   uvalueMInt(MI) >=Int 0    
    andBool   uvalueMInt(MI) <Int (2 ^Int (E -Int S))    

  rule extractMInt(MI:MInt, S:Int, E:Int) => mi(E -Int S, 0)
    requires  E<Int bitwidthMInt(MI)
    andBool   E >Int S
    andBool   bitwidthMInt(MI) >Int (E -Int S)
    andBool   uvalueMInt(MI) >=Int 0    
    andBool   uvalueMInt(MI) <Int (2 ^Int (bitwidthMInt(MI) -Int E))    

  
  syntax ByteVal ::= byte(Int, MInt)
  syntax AbstractValue ::= ByteVal
  syntax MemData ::= List{AbstractValue, ""} [klabel(abstractValueList)]

  syntax MInt ::= extractMask(MInt, Int, Int) [function]
  rule extractMask(MI, NUM, P) => extractMInt(MI, bitwidthMInt(MI) -Int P -Int NUM,
      bitwidthMInt(MI) -Int P)
    requires (P +Int NUM) <=Int bitwidthMInt(MI)


  syntax MInt ::= fromBytes(MemData) [function]
  rule fromBytes(byte(I:Int, MI:MInt) Rest) =>  extractMask(MI, 8, I *Int 8)
    requires Rest ==K .MemData
  rule fromBytes(byte(I:Int, MI:MInt) Rest:MemData) =>  concatenateMInt(fromBytes(Rest), extractMask(MI, 8, I *Int 8))
    requires Rest =/=K .MemData


    rule T:Task Ts:Tasks => T ~> Ts
    

    rule <k> task => . 
    ...</k>
      <state> ...
       "AB" |->  (
                MI => 
fromBytes(byte(0, extractMInt(mi(64, MI), 32, 64)) byte(1, extractMInt(mi(64, MI), 32, 64)) 
                  byte(2, extractMInt(mi(64, MI), 32, 64)) byte(3, extractMInt(mi(64, MI), 32, 64)) .MemData)
                )

       ...  </state>

endmodule
