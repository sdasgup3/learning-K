requires "domains.k"

module TEST16-SYNTAX
    imports MINT
    syntax Task ::=  "test" "(" Int "," Int "," Int  ")" [function]
                | "operate" "(" Int "," Int "," Int "," Int "," Int  ")" [function]

    syntax Tasks ::= List{Task, ""} 
endmodule

module TEST16
    imports TEST16-SYNTAX
    imports FLOAT

    configuration <k>$PGM:Tasks</k>

    rule T:Task Ts:Tasks => T ~> Ts

    syntax VOperation ::= "vfadd" [token]

    syntax MInts ::= List{MInt, ""} [klabel(mintlist)]
    syntax MInts ::= splitVector(MInt, Int) [function]
    syntax MInts ::= splitVectorHelper(MInt, Int, Int) [function]
    syntax MInt ::= joinVector(MInts) [function]
    syntax MInts ::= operateOnVector(MInts, MInts, VOperation, Int) [function]
    syntax MInts ::= operateOnVectorHelper(MInts, MInts, VOperation, Int, Int) [function]


    rule splitVector(MI, W) => splitVectorHelper(MI, W, 0)
      requires bitwidthMInt(MI) >=Int W andBool 0 =/=Int W
    rule splitVector(MI, W) => .MInts 
      requires bitwidthMInt(MI) <Int W orBool 0 ==Int W

    rule splitVectorHelper(MI, W, P) => extractMInt(MI, P, P +Int W) splitVectorHelper(MI, W, P +Int W)
      requires bitwidthMInt(MI) >Int P
    
    rule splitVectorHelper(MI, W, P) => .MInts
      requires bitwidthMInt(MI) ==Int P

    rule joinVector(MI .MInts) => MI
    rule joinVector(MI Rest) => concatenateMInt(MI, joinVector(Rest))

    rule operateOnVector(MI1, MI2, OP, OPW) => operateOnVectorHelper(MI1, MI2, OP, 53, 11)
      requires OPW ==Int 64
    rule operateOnVector(MI1, MI2, OP, OPW) => operateOnVectorHelper(MI1, MI2, OP, 24, 8)
      requires OPW ==Int 32

    rule operateOnVectorHelper(MI1 MI1s, MI2 MI2s, vfadd, P, E) => 
      Float2MInt(MInt2Float(MI1, P, E) +Float MInt2Float(MI2, P, E), P +Int E)  operateOnVectorHelper(MI1s, MI2s, vfadd, P, E)
    rule operateOnVectorHelper(.MInts, .MInts, _, _, _) => .MInts

    rule test(I, IW,  SUBIW) => joinVector(splitVector(mi(IW,I), SUBIW))

    rule operate(I1, I2, I3, W, P) =>  eqMInt(joinVector(operateOnVector(splitVector(mi(W,I1), P), splitVector(mi(W,I2), P), vfadd, P)), mi(W, I3))

    
                    

endmodule
