
module TEST26-SYNTAX
    imports MINT
    syntax Task ::=  "test" "(" Int ")" 

    syntax Tasks ::= List{Task, ""} [klabel(tasklist)]

endmodule

module TEST26
    imports TEST26-SYNTAX

    configuration 
    <T>
      <k>$PGM:Tasks</k>
      <state> mi(64,0) </state>
    </T>

    rule T:Task Ts:Tasks => T ~> Ts

    rule <k> test(I) => .
    ...</k>
    	<state> MI => addMInt(MI, mi(64, I)) </state>
   
    //syntax KItem ::= "empty"
    //rule <k> .Tasks => empty </k>


endmodule
