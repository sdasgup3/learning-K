
module TEST25-SYNTAX
    imports MINT
    syntax Task ::=  "test" "(" Int "," Int ")" [function] 
    syntax Register ::= R64
                  | R32
                  | R16

    syntax R64 ::= "%rax"
    syntax R32 ::= "%eax"
    syntax R16 ::= "%ax"
    syntax Tasks ::= List{Task, ""} [klabel(tasklist)]

endmodule

module TEST25
    imports TEST25-SYNTAX

    configuration 
    <T>
      <k>$PGM:Tasks</k>
    </T>

    rule T:Task Ts:Tasks => T ~> Ts

    syntax Rnew ::= R32 | R16
    syntax Absconds ::= exec(Rnew)


    rule <k> test(I,J) => exec(%eax)
    ...</k>
    rule <k> exec(R) => .
    ...</k>
   


endmodule
