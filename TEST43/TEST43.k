// config
module TEST43-SYNTAX
  imports INT
  imports MINT

  syntax Instructions ::= List{Instruction, ""} [klabel(instlist)]
  syntax Instruction ::= "execinst" "(" Opcode  Operands ")"
  syntax Operands ::= List{Operand, ","} [klabel(typeoperandlist)]


  syntax MemOffset ::= memoffset(MInt)
  syntax Operand ::=  Register 
                   |     Mem  
                   | MemOffset

  syntax Mem ::=  Int "(" Register ")" 
  syntax Register ::= "%rax" | "%rbx"

  syntax Opcode ::= "add" | "sub" 

  syntax KResult ::= MemOffset

endmodule

module TEST43
    imports TEST43-SYNTAX
 configuration 
    <T>
      <k> $PGM:Instructions </k>
      <store> mi(64, 0) </store>
    </T>

    rule T:Instruction Ts:Instructions => T ~> Ts


    rule <k> I:Int (R:Register) => memoffset( mi(64, I) )
    ...</k>

    context execinst(_:Opcode HOLE:Mem, R:Operand, .Operands)
    context execinst(_:Opcode _:Operand, HOLE:Mem, .Operands)

    context execinst(_:Opcode HOLE:Mem, _:Operand, _:Operand, .Operands)
    context execinst(_:Opcode _:Operand, HOLE:Mem, _:Operand, .Operands )
    context execinst(_:Opcode _:Operand, _:Operand, HOLE:Mem, .Operands )

    rule <k>
      execinst (_:Opcode R:Register, memoffset( MI:MInt ), .Operands) => .
    ...</k>
      <store> I => addMInt(I, MI)</store>

    rule <k>
      execinst (_:Opcode  memoffset( MI:MInt ), R:Register, .Operands) => .
    ...</k>
      <store> I => addMInt(I, MI)</store>

    rule <k>
      execinst(_:Opcode memoffset( MI:MInt), R1:Register, R2:Register, .Operands ) => .
    ...</k>
      <store> I => addMInt(I, MI)</store>

    rule <k>
      execinst(_:Opcode R1:Register, memoffset( MI:MInt), R2:Register, .Operands ) => .
    ...</k>
      <store> I => addMInt(I, MI)</store>

    rule <k>
      execinst(_:Opcode R1:Register, R2:Register, memoffset( MI:MInt), .Operands ) => .
    ...</k>
      <store> I => addMInt(I, MI)</store>
endmodule















