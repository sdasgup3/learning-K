// Passing List
module TEST-SYNTAX
    imports LIST
    imports MAP
    imports INT
    imports STRING

    syntax SList ::= List{String, ""}
    syntax Task ::=  "convert" "(" SList ")" 
endmodule

module TEST
    imports TEST-SYNTAX
    imports MINT
    imports STRING

    configuration 
    <T>
      <k> $PGM:Task </k>
      <store> 0 </store>
    </T>

    rule <k> convert(.SList)   => . 
    ...</k>

    rule <k> convert(S:String Rest:SList)   => convert(Rest)
    ...</k>
    <store> N => N +Int lengthString(S) </store>

    
endmodule
