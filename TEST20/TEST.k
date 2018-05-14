requires "domains.k"

module TEST20-SYNTAX
    imports DOMAINS-SYNTAX
    syntax Reg ::= "%rax" | "%rbx"
    syntax Task ::=  "update" "(" Reg "," Int "," Int ")" | 
          "show" "(" Reg ")" |
          "add" "(" Reg "," Int "," Int ")" |
          "zero" 

    syntax Tasks ::= List{Task, ""} [klabel(tasklist)]

endmodule

module TEST20
    imports TEST20-SYNTAX
    imports DOMAINS
    imports MINT

    configuration 
    <T>
      <k>$PGM:Tasks</k>
      <regstate>  
          ("RAX" |-> mi(64,0)) ("RBX" |-> mi(64,1) )
      </regstate>
    </T>

    rule T:Task Ts:Tasks => T ~> Ts

    syntax String ::= toReg(Reg) [function]
    rule toReg(%rax) => "RAX"
    rule toReg(%rbx) => "RBX"

    rule <k> update(R, I, J) => .K ...</k>
    <regstate> ... toReg(R) |-> (_  => mi(J,I))  ...</regstate>

    rule  <k> show(R) =>  RegMap[toReg(R)] ...</k>
      <regstate> RegMap:Map </regstate>

    rule  <k> add(R, I, J) =>  . ...</k>
      <regstate> RegMap:Map => RegMap[toReg(R) <- addMInt({RegMap[toReg(R)]}:>MInt, mi(J,I))]  </regstate>

    rule  <k> zero => . ...</k> 
      <regstate> RegMap => updateMap(RegMap, ("RBX" |-> mi(64,0)) ("RAX" |-> mi(64,0)))   </regstate>
endmodule
