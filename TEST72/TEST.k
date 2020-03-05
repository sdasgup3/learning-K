module TEST-SYNTAX
    imports MINT
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
    //syntax GraphDFG ::= graph (Map )
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
      ("RAX" |->    mi(64,  0 :Int))
      ("RBX" |->    mi(64,  0 :Int))
      ("YMM0" |->    mi(256,  1 :Int))
      ("YMM1" |->    mi(256,  2 :Int))
    </state>
    <nextLocPc> mi(64, 0) </nextLocPc>
    <text> code( .Map ) </text>
    <dfg> 
      <graph> 
        .Map  
      </graph>
      <graphiter> 
        mi(64,0)  
      </graphiter>
    </dfg>
    </T>

    rule T:Instruction Ts:Instructions => T ~> Ts

     rule  <k> OpC:Opcode OpR:Typedoperands => . ...</k>
        <text> code(M:Map => M[  L <- storedInstr(OpC OpR)])</text>
        <nextLocPc> L:MInt => addMInt(L, mi(64, 1)) </nextLocPc>

  rule  <k>.Instructions => .K ...</k>

endmodule

