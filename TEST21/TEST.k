require "TEST21-UTILS.k"

module TEST21-SYNTAX
    imports INT
    syntax Task ::=  "test" "(" Int "," Int ")" 

    syntax Tasks ::= List{Task, ""} [klabel(tasklist)]

endmodule

module TEST21-CONFIG
//module TEST21
    imports TEST21-SYNTAX
    imports TEST21-UTILS-SYNTAX
    //imports TEST21-UTILS

    configuration 
    <T>
      <k>$PGM:Tasks</k>

      <regstate> zeroMIntW64  </regstate>
    </T>
endmodule

module TEST21
    imports TEST21-CONFIG
    //imports TEST21-UTILS

    rule T:Task Ts:Tasks => T ~> Ts

    rule <k> test(I,J) => . ...</k>
      <regstate> K => addMInt(K, mi(J,I))  </regstate>

endmodule
