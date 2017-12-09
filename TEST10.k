requires "domains.k"

module TEST10-SYNTAX
    imports MINT

    syntax Ignore ::= ".section" ".text" [token]
    syntax Label ::= "_start" ":"

    syntax Task ::=  "add" "(" Int "," Int ")"
                  | Ignore
                  | Label
    syntax Tasks ::= List{Task, ""} [klabel(tasklist)]
endmodule

module  TEST10
    imports TEST10-SYNTAX

    configuration <k>$PGM:Tasks</k>

    rule T:Task Ts:Tasks => T ~> Ts
    // With token, both rules wont work
    //rule <k>  .section .text  => . ...</k> 
    rule <k>  I:Ignore  => . ...</k> 

    // W/O token, 1st rule wont work
    //rule <k>  _start:    => . ...</k> 
    rule <k>  L:Label => . ...</k> 

    //Also with "_start" ":"  [token]
    // rule must have _start: NOT _start :

    rule add(W:Int, I:Int) => W +Int I
endmodule
