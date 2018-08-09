//  krun  '-cARGV0=(#token("\"mango\"","String@STRING-SYNTAX") |-> 10) (#token("\"apple\"","String@STRING-SYNTAX") |-> 20)' '-pARGV0=printf %s' TEST.test



module TEST-SYNTAX
    imports MAP
    imports INT
    syntax Task ::= "task" "(" Int ")" 

endmodule

module TEST
    imports TEST-SYNTAX

    configuration 
      <k> $PGM:Task </k>
      <regstate> $ARGV0:Map </regstate>

    rule <k>  
    task(I:Int) => 0
    ...</k>
    <regstate> M:Map </regstate>
endmodule
