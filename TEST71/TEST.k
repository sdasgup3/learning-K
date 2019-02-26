requires "x86-float-conversions.k"

module TEST-SYNTAX
  imports INT
  imports MINT
  imports FLOAT-CONVERSIONS

  syntax Task ::= "test1" "(" Float ")" [function]
  syntax Task ::= "test2" "(" Float ")" [function]
  syntax Task ::= "test3"  [function]
  syntax Task ::= "test4"  [function]
  syntax Tasks ::= List{Task, ""}
  syntax Task ::= Bool
endmodule

module TEST
  imports TEST-SYNTAX

  configuration <k>$PGM:Tasks</k>

    rule <k> T:Task Ts:Tasks => T ~> Ts </k>

    rule test1(F:Float) => isPositiveZero(F)
    rule test2(F:Float) => isNegativeZero(F)
    rule test3 => isPositiveZero(GetInfinity(53, 11))
    rule test4 => isNegativeZero(GetInfinity(24, 8))

endmodule
