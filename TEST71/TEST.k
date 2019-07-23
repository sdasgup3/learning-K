requires "x86-float-conversions.k"

module TEST-SYNTAX
  imports INT
  imports MINT
  imports FLOAT-CONVERSIONS

  syntax Task ::= "test1" "(" Float ")" [function]
  syntax Task ::= "test2" "(" Float ")" [function]
  //syntax Task ::= "test3" "(" Float ")" [function]
  //syntax Task ::= "test4" "(" Float ")" [function]


  syntax Tasks ::= List{Task, ""}
  syntax Task ::= Bool
  //syntax Task ::= Int
endmodule

module TEST
  imports TEST-SYNTAX

  configuration <k>$PGM:Tasks</k>

    rule <k> T:Task Ts:Tasks => T ~> Ts </k>

    rule test1(F:Float) => isPositiveZero(F)
    rule test2(F:Float) => isNegativeZero(F)
    //rule test3(F:Float) => exponentFloat(F)
    //rule test4(F:Float) => ExponentBitVectorFloat(F)

endmodule
