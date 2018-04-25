requires "domains.k"

module TEST4-SYNTAX
 imports DOMAINS-SYNTAX
    imports MINT



    //syntax Comment ::= ";" r"[^\\n]*[\\n]" [token]

    syntax Task ::=  "add" "(" Int "," Int ")" 
    syntax Tasks ::= List{Task, ""}
endmodule

module TEST4
    imports TEST4-SYNTAX
    imports DOMAINS
    

    configuration <k>$PGM:Tasks</k>
    rule T:Task Ts:Tasks => T ~> Ts

    // Following 2 rules are the same.
    rule <k>  R:Tasks  => R ...</k> // Rule 1
    rule add(W:Int, I:Int) => W +Int I
endmodule
