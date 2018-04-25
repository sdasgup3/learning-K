module TEST27-SYNTAX
    imports MINT
    syntax Task ::=  "oldinst1" "(" Int ")"
                   | "oldinst2" "(" Int ")"

    syntax Tasks ::= List{Task, ""} [klabel(tasklist)]

endmodule

module TEST27
    imports TEST27-SYNTAX

    configuration 
    <T>
      <k> $PGM:Tasks </k>
      <state> ?I:MInt </state>
    </T>

    rule T:Task Ts:Tasks => T ~> Ts

    rule <k> oldinst1(I) => .
    ...</k>
    	<state> MI => addMInt(MI, mi(64, I)) </state>
   
    rule <k> oldinst2(I) => .
    ...</k>
    	<state> MI => mulMInt(MI, mi(64, I)) </state>

endmodule
