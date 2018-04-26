
module TEST1-SYNTAX
    imports DOMAINS-SYNTAX

    syntax HexConstant ::=  r"$0x[0-9a-fA-F]+" [prefer, token, prec(2)]
    syntax Imm ::=   "$" Int
                  | HexConstant
    syntax Task ::=  "convert" "(" Imm "," Int ")" [function]
    syntax Tasks ::= List{Task, ""}
endmodule

module TEST1
    imports TEST1-SYNTAX
    imports MINT

    configuration <k>$PGM:Tasks</k>

    rule T:Task Ts:Tasks => T ~> Ts

    rule 1 *Int I:Int => I

    syntax String ::= HexConstant2String ( HexConstant )    [function, hook(STRING.token2string)]
    rule convert((H:HexConstant):Imm, I:Int) => 
              mi(I, String2Base(substrString(HexConstant2String(H), 3, lengthString(HexConstant2String(H))), 16))
    rule convert(($ M:Int):Imm, I:Int) => 
              mi(I, M)
    
endmodule
