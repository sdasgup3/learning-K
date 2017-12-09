requires "domains.k"

module TEST2-SYNTAX
    imports MINT


    syntax MInt ::= "undef"
    syntax Task ::=  "add" "(" Int "," Int ")" 
    syntax Tasks ::= List{Task, ""}
endmodule

module TEST2
    imports TEST2-SYNTAX


    configuration 
    <T>
      <k>$PGM:Tasks</k>
      <store> mi(1,0) </store>
    </T>  

    rule I:Task Is:Tasks => I ~> Is
    rule <k> add ( W:Int, I:Int ) => W +Int I ...</k>
    <store> _ => undef </store>

endmodule
