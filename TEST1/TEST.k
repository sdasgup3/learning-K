// HexConstant
// Macro
module TEST-SYNTAX
    imports DOMAINS-SYNTAX

    syntax HexConstant ::=  r"$0x[0-9a-fA-F]+" [prefer, token, prec(2)]
    syntax Imm ::=   "$" Int
                  | HexConstant
    syntax Task ::=  "convert" "(" Imm "," Int ")" [function]
    syntax Task ::=  "testMacro" "(" Int "," Int ")" [function]
    syntax Tasks ::= List{Task, ""}
endmodule

module TEST
    imports TEST-SYNTAX
    imports MINT

    configuration <k>$PGM:Tasks</k>

    rule T:Task Ts:Tasks => T ~> Ts

    rule 1 *Int I:Int => I
    
    syntax MInt ::= "zeroMIntW64"
    rule zeroMIntW64  =>  mi(64, 0) [macro]


    syntax String ::= HexConstant2String ( HexConstant )    [function, hook(STRING.token2string)]
    rule convert((H:HexConstant):Imm, I:Int) => 
              mi(I, String2Base(substrString(HexConstant2String(H), 3, lengthString(HexConstant2String(H))), 16))
    rule convert(($ M:Int):Imm, I:Int) => 
              mi(I, M)

    rule testMacro(I, J) => addMInt(mi(I, J), zeroMIntW64)
    
endmodule
