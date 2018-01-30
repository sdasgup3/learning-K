requires "domains.k"

// opcode as string


module TEST37-SYNTAX
    imports MINT
  syntax Instruction ::=  Opcode Typedoperands
        
  syntax Opcode ::= String
  syntax Typedoperands ::= List{Typeoperand, ","} [klabel(typeoperandlist)]
  syntax Typeoperand ::=  Register
  syntax Register ::= Rh
                    | R8
  syntax Rh ::= "%ah"
              | "%bh"
              | "%ch"
              | "%dh"
  syntax R8 ::= "%al"
              | "%bl"
              | "%cl"
              | "%dl"
              | "%sil"
              | "%dil"
              | "%spl"
              | "%bpl"
              | "%r8b"
              | "%r9b"
              | "%r10b"
              | "%r11b"
              | "%r12b"
              | "%r13b"
              | "%r14b"
              | "%r15b"


    syntax Task ::=  "execinstr" "(" Instruction ")"
    syntax Tasks ::= List{Task, ""} [klabel(tasklist)]

endmodule

module TEST37
    imports TEST37-SYNTAX

    configuration 
    <T>
    <k>$PGM:Tasks</k>
    <state> 
      ("RAX" |->    mi(64,  0 :Int))
      ("CF" |->     mi(1,   1 :Int))
    </state>
    </T>

    rule T:Task Ts:Tasks => T ~> Ts

    rule <k> execinstr("addq" R1:Register, R2:Register, .Typedoperands) => .
    ...</k>
    <state> ...
            "RAX" |->  (_ => mi(64, 2))
     ...</state>       

    rule <k> execinstr("subq" R1:Register, R2:Register, .Typedoperands) => .
    ...</k>
    <state>... 
            "RAX" |->  (_ => mi(64, 20))
     ...</state>       



endmodule

