// krun   '-cARGV0=#token("1","Int")' '-pARGV0=printf %s'  TEST.test 
// krun   '-cARGV1=mi(#token("64","Int"),#token("0","Int"))' '-pARGV1=printf %s' TEST.test
// krun   '-cARGV2=#token("\"mango\"","String")' '-pARGV2=printf %s'      TEST.test 
// `_|->_`(#token("\"mango\"","String), #token("1","Int"))

module TEST-SYNTAX
    imports MAP
    imports INT
    imports MINT
    imports STRING
    syntax Task ::= "task" "(" MInt ")" 

endmodule

module TEST
    imports TEST-SYNTAX

    configuration 
      <k> $PGM:Task </k>
      <regstate0> $ARGV0:Int </regstate0>
      <regstate1> $ARGV1:MInt </regstate1>
      <regstate2> $ARGV2:String </regstate2>
      <regstate3> $ARGV3:Map </regstate3>

    rule <k>  
    task(MI:MInt) => 0
    ...</k>
    <regstate0> I:Int </regstate0>
    <regstate1> MI:MInt </regstate1>
    <regstate2> S:String </regstate2>
    <regstate3> M:Map </regstate3>
endmodule
