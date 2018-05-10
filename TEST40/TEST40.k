// Macro
module TEST40-SYNTAX
    imports INT

    syntax Task ::=  "convert" "(" Int ")"  [function]
    syntax Tasks ::= List{Task, ""}
endmodule

module TEST40
    imports TEST40-SYNTAX
    imports MINT

    configuration <k>$PGM:Tasks</k>

    rule T:Task Ts:Tasks => T ~> Ts

    syntax Int ::= "AddrSize" 
    rule AddrSize => 64 [macro]

    rule  convert(I:Int) => addMInt( mi(AddrSize, I), mi(AddrSize, AddrSize)) 
    
   endmodule
