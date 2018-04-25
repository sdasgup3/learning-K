module TEST21-UTILS-SYNTAX
  imports MINT

  syntax MInt ::= "zeroMIntW64" 
endmodule

module TEST21-UTILS
  imports TEST21-UTILS-SYNTAX
  rule zeroMIntW64  =>  mi(64, 0) [macro]
endmodule
