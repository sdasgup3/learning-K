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
    syntax Opcode ::= "add" | "sub" | "callq"
    syntax Operand ::= Reg | X86Id
    syntax Operands ::= List{Operand, ","}
    syntax Reg ::= "rax"
                  | "rbx"


    syntax X86Id ::= Id
    syntax X86Ids ::= List{X86Id, ","} [klabel(x86idlist)]
              
    syntax Label ::= X86Id ":"

    syntax AssemblerDirective ::=  ".globl" X86Id
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

    rule <k> _:Opcode R1:Reg, R2:Reg, .Operands => .
    ...</k>
      <pc> C:Int => C +Int 1 </pc>


    rule <k> (LabelName:X86Id:):Label => . ...</k>
        <pc> L </pc>
        <store> FMap:Map => FMap[LabelName <- L]
        </store>            

    rule <k> callq LabelName:X86Id => . ...</k>
        <pc> L => NewPC </pc>
        <store> ... LabelName |-> NewPC ...</store>



endmodule
