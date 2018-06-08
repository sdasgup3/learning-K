// krun '-cARGV0=store("rax", mi(64, 0)) store("rbx", mi(64, 1))'      TEST.test

module TEST-SYNTAX
    imports MINT
    imports FLOAT
    imports BOOL
    syntax MInt ::= "#ifMInt"   Bool "#then" MInt  "#else" MInt  "#fi" [function]
    syntax Task ::= "max" "(" MInt "," MInt ")" 

endmodule

module TEST
    imports TEST-SYNTAX

    configuration 
      <k> $PGM:Task </k>


    rule #ifMInt B #then W #else _ #fi => W requires B
    rule #ifMInt B #then _ #else W #fi => W requires notBool B


    rule <k>  
    max(MI1:MInt, MI2:MInt) =>  Float2MInt(maxFloat( MInt2Float(MI1, 24, 8),
                                                  MInt2Float(MI2, 24, 8)), 32) 

    ...</k>

endmodule
