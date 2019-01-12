module TEST-SYNTAX
  imports INT
  imports FLOAT

 //syntax Instructions ::= List{Instruction, ""} [klabel(instructionlist)]
  syntax Instruction ::=  Opcode Operands

  //syntax Operands ::= List{Operand, ","} [klabel(operandlist)]
  syntax Operands ::= Int "," Float "," Int


  //syntax Operand ::=  Int
  //                     | Float


  syntax Opcode ::= "pseudofloattestopcode1"
endmodule

module TEST

  imports TEST-SYNTAX

    //configuration <k>$PGM:Instructions</k>
    configuration <k>$PGM:Instruction</k>


    syntax Abstractinstruction ::= execinstr(Instruction)

  rule  <k> OpC:Opcode OpR:Operands => execinstr(OpC OpR) ...</k>

  rule <k>
    //execinstr (pseudofloattestopcode1:Opcode I:Int, F:Float,   .Operands) => .
    execinstr (pseudofloattestopcode1:Opcode I:Int, F:Float, J:Int) => .
  ...</k>


endmodule
