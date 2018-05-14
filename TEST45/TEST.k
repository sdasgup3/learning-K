// config
module TEST-SYNTAX
  imports INT
  imports MINT
  imports MAP
  imports STRING

  syntax Instruction ::= "task" "(" String "," Int ")"
  syntax Instructions ::= List{Instruction, ""} 

  syntax CodeInMem ::= code(Map)


endmodule

module TEST
    imports TEST-SYNTAX
 configuration 
    <T>
      <k> $PGM:Instructions </k>
      <store> code(.Map) </store>
    </T>

    rule T:Instruction Ts:Instructions => T ~> Ts


    rule <k>
      task(S:String, I:Int ) => .
    ...</k>
      <store> code(M => M[S <- I]) </store>
endmodule















