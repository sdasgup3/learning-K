requires "domains.k"

// rules involving same hask keys
// [Error] Critical: failed to concatenate maps with common keys:



module TEST38-SYNTAX
    imports MINT
  syntax Instruction ::=  Opcode Typedoperands
        
  syntax Opcode ::= "vmovdqa" [token]
                    | "vmovdqu" [token]
                    | "xchg" [token]
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

  syntax MInt ::= getRegisterValue(Register,  Map)  [function]
   rule getRegisterValue(R:Register,  RSMap:Map)  =>  RSMap[convToRegKeys(R)]:>MInt
  

  rule convToRegKeysHelper(%ymm0)  => "YMM0"
  rule convToRegKeysHelper(%ymm1)  => "YMM1"
  rule convToRegKeysHelper(%rax)  => "RAX"
  rule convToRegKeysHelper(%rbx)  => "RBX"

  rule convSubRegsToRegs(%rax )  => %rax
  rule convSubRegsToRegs(%rbx )  => %rbx
  rule convSubRegsToRegs(%ymm0 )  => %ymm0
  rule convSubRegsToRegs(%ymm1 )  => %ymm1

  rule mi(256, uvalueMInt(extractMInt(MI1, 0, 256))) => MI1


   rule <k>
    execinstr (xchg R1:Ymm, R2:Ymm,  .Typedoperands) => .
  ...</k>
    <state> ...
      //convToRegKeys(R1) |-> (MI1:MInt => MI2)
      convToRegKeys(R1) |-> (MI1:MInt => MI2)
      convToRegKeys(R2) |-> (MI2:MInt => mi(256, uvalueMInt(extractMInt(MI1, 0, 256))))
      //convToRegKeys(R2) |-> (MI2:MInt => mi(256, uvalueMInt(extractMInt(MI1, 128, 256))))
    ... </state>

   rule <k>
    execinstr (vmovdqa R1:Ymm, R2:Ymm,  .Typedoperands) => .
  ...</k>
    <state> 
    RSMap:Map => updateMap(RSMap, 
        
        convToRegKeys(R2) |-> ( mi(256, uvalueMInt(extractMInt(getRegisterValue(R1, RSMap), 128, 256))) ) 
        )
    </state>

    /*
    <state>
    (convToRegKeys(R2) |->  MI2) RSMap:Map 
    => 
    (convToRegKeys(R2) |-> mi(256, uvalueMInt(extractMInt(getRegisterValue(R1, RSMap), 128, 256))) ) RSMap
    </state>
    */
endmodule

