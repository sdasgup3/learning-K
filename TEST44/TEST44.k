// config
module TEST44-SYNTAX
  imports INT
  imports MINT

  syntax Instructions ::= List{Instruction, ""} [klabel(instlist)]
  syntax Instruction ::= "task" "(" K ")" [strict(1)]

  syntax KResult ::= MInt

endmodule

module TEST44
    imports TEST44-SYNTAX
 configuration 
    <T>
      <k> $PGM:Instructions </k>
      <store> mi(64, 0) </store>
    </T>

    rule T:Instruction Ts:Instructions => T ~> Ts


    rule <k>
      task(MI:MInt ) => .
    ...</k>
      <store> I => addMInt(I, MI)</store>
endmodule















