//  krun '-cARGV0=#token("30","Int")' '-pARGV0=printf %s'  '-cARGV1=mi(#token("64","Int"),#token("30","Int"))' '-pARGV1=printf %s'  '-cARGV2=`_List_`(`ListItem`(#token("\"apple\"","String@STRING-SYNTAX")),`_List_`(`ListItem`(#token("\"mango\"","String@STRING-SYNTAX")),`.List`(.KList))))))'  '-pARGV2=printf %s' TEST.test

module TEST-SYNTAX
    imports MINT
    imports MAP
    imports STRING
    imports INT
    syntax Task ::= "task" "(" Int ")" 

    syntax Tasks ::= List{Task, ""}

endmodule

module TEST
    imports TEST-SYNTAX

    configuration 
      <k> $PGM:Tasks </k>
      <regstate1> $ARGV0:Int </regstate1>
      <regstate2> $ARGV1:MInt </regstate2>
      <regstate3> $ARGV2:List </regstate3>

    rule <k>
      T:Task Ts:Tasks =>  T ~> Ts
    </k>

    rule <k>  
    //task(M:Map) => 0
    //task(L:List) => 0
    task(I:Int) => 0
    ...</k>
    <regstate1> I:Int </regstate1>
    <regstate2> MI:MInt </regstate2>
    <regstate3> L:List </regstate3>
    

    

endmodule
