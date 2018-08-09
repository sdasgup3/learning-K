require "bv.k"
module TEST-SYNTAX
    imports BV
    imports INT

    syntax Task ::= "task" "(" BV ")" 
    syntax Task ::= BV

endmodule

module TEST
    imports TEST-SYNTAX

    configuration 
      <k> $PGM:Task </k>


      rule <k> task(MI1:BV) => addBV(MI1, bv(64, 0))
      </k>
endmodule
