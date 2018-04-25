requires "domains.k"

// parseToken Usage

module TEST31-SYNTAX
    imports DOMAINS-SYNTAX
    imports INT-SYNTAX
    imports MINT
    syntax Task ::=  "task" "(" Int "," Int ")" 
    syntax Tasks ::= List{Task, ""} [klabel(tasklist)]

endmodule

module TEST31
    imports TEST31-SYNTAX
    imports DOMAINS
    imports INT

    configuration <k>$PGM:Tasks</k>

    rule T:Task Ts:Tasks => T ~> Ts

    syntax KItem ::= write (Int) 

    rule <k> task(I, J) => addMInt({#parseToken("MInt", "64'100")}:>MInt, 
          mi(J, ( {#parseToken("Int", Int2String(I))}:>Int +Int J )) )
    ...</k>
                                        
endmodule
