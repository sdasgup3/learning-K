
module TEST22-SYNTAX
  imports DOMAINS-SYNTAX

  syntax Opcode ::= "add" | "sub"
  syntax Operand ::= Reg
  syntax Reg::= R8 | Rh
  syntax Operands ::= List{Operand, ","} [klabel(operandlist)]
  syntax Instr ::=  Opcode Operands
  syntax Program ::= List{Instr, ""} [klabel(programlist)]

  syntax R8 ::= "%al" | "%bl"
  syntax Rh ::= "%ah" | "%bh"

endmodule

module TEST22
    imports TEST22-SYNTAX
    imports DOMAINS
    imports MINT

    configuration 
    <T>
      <k>$PGM:Program</k>
      <cmem> .Map </cmem>
      <nextloc> 0:Int </nextloc>
      <rax> 0:Int </rax>
      <rbx> 0:Int </rbx>
    </T>

    //syntax K ::= storeInstr(Opcode, Operands) 
    syntax K ::= storeInstr(Instr)
    rule I:Instr P:Program => I ~> P

    rule
    <k> OpC:Opcode OpR:Operands => .  ... </k>
      <cmem>... .Map => L |-> storeInstr(OpC OpR) ...</cmem>
      <nextloc> L => L +Int 1 </nextloc>

    /*
    syntax KItem ::= setRegVal(Reg, Int) 
    syntax Int ::= getRegVal(Reg) [function] 

    rule <k> setRegVal(%al, I) => . ...</k>
    <rax> _ => I </rax>
    rule <k> setRegVal(%ah, I) => . ...</k>
    <rax> _ => I </rax>

    rule <k> setRegVal(%bl, I) => . ...</k>
    <rbx> _ => I </rbx>
    rule <k> setRegVal(%bh, I) => . ...</k>
    <rbx> _ => I </rbx>

    rule getRegVal((R:R8):Reg) => 16
    rule getRegVal((R:Rh):Reg) => 8

    rule <k> add R1:R8, R2:Rh, .Operands => setRegVal(R2, getRegVal(R1) +Int getRegVal(R2) ) 
    ...</k>
    */

endmodule
