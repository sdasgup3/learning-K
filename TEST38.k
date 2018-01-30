requires "domains.k"

// rules involving same hask keys


module TEST38-SYNTAX
    imports MINT
  syntax Instruction ::=  Opcode Typedoperands
        
  syntax Opcode ::= "vmovdqa" [token]
  | "vmovdqu" [token]
  syntax Typedoperands ::= List{Typeoperand, ","} [klabel(typeoperandlist)]
  syntax Typeoperand ::=  Register
  syntax Register ::= R64
                    | Ymm
  syntax R64 ::= "%rax"
              | "%rbx"
  syntax Ymm ::= "%ymm0"
              | "%ymm1"


    syntax Task ::=  "execinstr" "(" Instruction ")"
    syntax Tasks ::= List{Task, ""} [klabel(tasklist)]

endmodule

module TEST38
    imports TEST38-SYNTAX

    configuration 
    <T>
    <k>$PGM:Tasks</k>
    <state> 
      ("RAX" |->    mi(64,  0 :Int))
      ("RBX" |->    mi(64,  0 :Int))
      ("YMM0" |->    mi(256,  1 :Int))
      ("YMM1" |->    mi(256,  2 :Int))
    </state>
    </T>

    rule T:Task Ts:Tasks => T ~> Ts


    syntax String ::= convToRegKeys(Register) [function]
    syntax String ::= convToRegKeysHelper(Register) [function]
    rule convToRegKeys(R) =>  convToRegKeysHelper(convSubRegsToRegs(R))
  syntax R64 ::= convSubRegsToRegs(Register) [function]
  syntax Ymm ::= convSubRegsToRegs(Register) [function]

  rule convToRegKeysHelper(%ymm0)  => "YMM0"
  rule convToRegKeysHelper(%ymm1)  => "YMM1"
  rule convToRegKeysHelper(%rax)  => "RAX"
  rule convToRegKeysHelper(%rbx)  => "RBX"

  rule convSubRegsToRegs(%rax )  => %rax
  rule convSubRegsToRegs(%rbx )  => %rbx
  rule convSubRegsToRegs(%ymm0 )  => %ymm0
  rule convSubRegsToRegs(%ymm1 )  => %ymm1


   rule <k>
    execinstr (vmovdqa R1:Ymm, R2:Ymm,  .Typedoperands) => .
  ...</k>
    <state> ...
  convToRegKeys(R1) |-> (MI676 => MI676)

  convToRegKeys(R2) |-> ( _ => MI676 )


    ...</state>

   rule <k>
    execinstr (vmovdqu R1:Ymm, R2:Ymm,  .Typedoperands) => .
  ...</k>
    <state> ...
  convToRegKeys(R1) |-> (MI676:MInt => MI676)

  convToRegKeys(R2) |-> ( _ => MI676 )


    ...</state>

endmodule

