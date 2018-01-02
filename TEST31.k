requires "domains.k"

// parseToken Usage

module TEST31-SYNTAX
    imports MINT
    syntax Task ::=  "task" "(" Int "," Int ")" 
    syntax Tasks ::= List{Task, ""} [klabel(tasklist)]

endmodule

module TEST31
    imports TEST31-SYNTAX

    configuration <k>$PGM:Tasks</k>

    rule T:Task Ts:Tasks => T ~> Ts

    syntax KItem ::= write (Int) 

    rule <k> task(I, J) => addMInt(#parseToken("MInt@MINT", "64'100"):>MInt, 
          mi(J, ( #parseToken("Int@INT-SYNTAX", Int2String(I)):>Int +Int 2 )) )
    ...</k>
                                        
endmodule
