// Label parsing
module TEST-SYNTAX
    imports LIST
    imports INT
    imports ID
    imports MAP

    syntax Task ::= Opcode Operands
                  | AssemblerDirective
                  | Label

    syntax Tasks ::= List {Task, ""} 
    syntax Opcode ::= "add" | "sub" 
    syntax Operand ::= Reg
    syntax Operands ::= List{Operand, ","}
    syntax Reg ::= "rax"
                  | "rbx"


    syntax X86id ::= r"[a-zA-Z\\.\\_][0-9a-zA-Z\\.\\_]*" 
    syntax X86ids ::= List{X86id, ","} [klabel(x86idlist)]
              
    syntax Label ::= X86id ":"

    syntax AssemblerDirective ::=  ".globl" X86id
                              | ".section" SectionName
    syntax SectionName ::= ".text"  [token]
                          | ".data" [token] 
                          | ".bss"  [token]

endmodule

module TEST
    imports TEST-SYNTAX
    imports MINT
    imports STRING

    configuration 
    <T>
      <k> $PGM:Tasks </k>
      <store> .Map </store>
      <pc> 0 </pc>
    </T>

    rule <k> T:Task Ts:Tasks => T ~> Ts
    ...</k>

    rule <k> _:AssemblerDirective => .
    ...</k>

    rule <k> .globl LabelName:X86id  => . 
    ...</k>

    rule <k> _:Opcode R1:Reg, R2:Reg, .Operands => .
    ...</k>
      <pc> C:Int => C +Int 1 </pc>


    rule <k> (LabelName:X86id:):Label => . ...</k>
        <pc> L </pc>
        <store> FMap:Map => FMap[LabelName <- L]
        </store>            



endmodule
