// Label parsing
module TEST-SYNTAX
    imports LIST
    imports INT
    imports ID
    imports MAP
    imports BUILTIN-ID-TOKENS

    syntax X86id ::= r"(?<![A-Za-z0-9\\_])[A-Za-z\\_][A-Za-z0-9\\_]*" [prec(1), notInRules, token, autoReject]
        | r"[a-z][a-zA-Z0-9]*" [prec(2)]
        | r"[A-Z][a-zA-Z0-9]*" [prec(2)]

    syntax Task ::= X86id

endmodule

module TEST
    imports TEST-SYNTAX
    imports MINT
    imports STRING

    configuration 
    <T>
      <k> $PGM:X86id </k>
      <store> .Map </store>
      <pc> 0 </pc>
    </T>

    rule <k> name:X86id => . ...</k>


endmodule
