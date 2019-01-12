module DEF-SYNTAX
  imports FLOAT-SYNTAX
 // imports ID // Float will be parsed. Uncomment it and Infinity will be treated as ID
endmodule

module DEF
  imports DEF-SYNTAX
  configuration <k> $PGM:Float </k>
endmodule
