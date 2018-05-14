// config
module TEST42-SYNTAX
    imports MINT

    syntax Task ::=  "init" "(" Int ")" 

    syntax Mysort

    // subTask cannot be MInt; then subtask rule will not triiger as subTask sort == Kresult
    syntax Mysort ::=  "subTask" "(" Int ")"
    syntax Mysort ::= MInt

    syntax KItem ::=  "task" "(" Mysort ")" [strict(1)]
    syntax KResult ::= MInt
    syntax Tasks ::= List{Task, ""}
endmodule

module TEST42
    imports TEST42-SYNTAX
    imports MINT
    imports STRING

    configuration 
    <T>
      <k> $PGM:Tasks </k>
    </T>

    rule T:Task Ts:Tasks => T ~> Ts

    rule <k> subTask(I:Int) => mi(64, I) ...</k>

    rule <k> task(MI:MInt) => addMInt(MI, mi(64, 10)) ...</k>

    rule <k> init (I:Int) => task(subTask(I)) ...</k>
    

    
endmodule
