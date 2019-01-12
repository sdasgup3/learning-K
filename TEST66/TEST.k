module TEST-SYNTAX

  imports INT
  imports MINT
  imports FLOAT // Not passing this FLOAT inhinits fp / fp to be passed as a float

  /*@ 
    The following captures  the At&t syntax of x86 assembly.
  */
  syntax Instructions ::= List{Instruction, ""} [klabel(instructionlist)]
  syntax Instruction ::=  Opcode Operands


  syntax Operands ::= List{Operand, ","} [klabel(operandlist)]

  syntax Operand ::= Int
                       | Float
                       | MInt

  syntax Opcode ::= "pseudofloattestopcode1"
endmodule

module TEST

  imports TEST-SYNTAX

    configuration <k>$PGM:Instructions</k>

    rule I:Instruction Is:Instructions => I ~> Is



    syntax Abstractinstruction ::= execinstr(Instruction)

  rule  <k> OpC:Opcode OpR:Operands => execinstr(OpC OpR) ...</k>

   rule <k>
    execinstr (pseudofloattestopcode1:Opcode I:Int, F:Float,  W:Int, P:Int, E:Int, .Operands) => .
  ...</k>


endmodule
