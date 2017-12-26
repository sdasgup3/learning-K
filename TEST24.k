
module TEST24-SYNTAX
    imports MINT
    syntax Task ::=  "test1" "(" Int "," Int "," Int ")" [function] 
     |   "test2" "(" Int "," Int "," Int ")" [function] 
    syntax Tasks ::= List{Task, ""} [klabel(tasklist)]

endmodule

module TEST24
    imports TEST24-SYNTAX

    configuration 
    <T>
      <k>$PGM:Tasks</k>
    </T>

    rule T:Task Ts:Tasks => T ~> Ts



    rule test1(I, J, K) =>  ashrMInt(mi(I, J), K)
    rule   test2(I, J, K) =>  lshrMInt(mi(I, J), K)
   


endmodule
