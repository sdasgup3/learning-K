module TEST-SYNTAX
    imports MAP
    imports DOMAINS-SYNTAX

    syntax Instructions ::= List{Instruction, ""} [klabel(instructionlist)]
  syntax Instruction ::=  Opcode Typedoperands
        
  syntax Opcode ::= "vmovdqa"
                    | "vmovdqu"
                    | "xchg"
                    | "xchgtest"
  syntax Typedoperands ::= List{Typeoperand, ","} [klabel(typeoperandlist)]
  syntax Typeoperand ::=  Register
  syntax Register ::= R64
                    | Ymm
  syntax R64 ::= "%rax"
              | "%rbx"
  syntax Ymm ::= "%ymm0"
              | "%ymm1"


    syntax CodeInMemory ::= code ( Map )
  syntax Abstractinstruction ::= storedInstr(Instruction)

endmodule

module TEST
    imports TEST-SYNTAX
    imports DOMAINS



    configuration 
    <T>
    <k>
      $PGM:Instructions 
    </k>
    <state> 
      ("RAX" |->      0:Int)
      ("RBX" |->      0:Int)
      ("YMM0" |->     1:Int)
      ("YMM1" |->     2:Int)
    </state>
    <nextLocPc>  0 </nextLocPc>
    <text> code( .Map ) </text>
    </T>

    rule T:Instruction Ts:Instructions => T ~> Ts

     rule  <k> OpC:Opcode OpR:Typedoperands => . ...</k>
        <text> code(M:Map => M[  L <- storedInstr(OpC OpR)])</text>
        <nextLocPc> L:Int => L +Int 1 </nextLocPc>

  rule  <k>.Instructions => .K ...</k>

endmodule

