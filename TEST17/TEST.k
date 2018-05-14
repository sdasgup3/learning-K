requires "domains.k"

module TEST17-SYNTAX
    imports MINT
    syntax Task ::=  "test" "(" Int "," Int "," Int  ")" [function, klabel(testthreearg)]
                | "test" "(" Int "," Int ")" [function, klabel(testtwoarg)]

    syntax Tasks ::= List{Task, ""} 
endmodule

module TEST17
    imports TEST17-SYNTAX
    imports FLOAT

    configuration <k>$PGM:Tasks</k>

    rule T:Task Ts:Tasks => T ~> Ts


   rule test(I,J) => I +Int J 
   rule test(I,J, K) => I +Int J -Int K 
                    

endmodule
