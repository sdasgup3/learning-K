// Passing List
module TEST-SYNTAX
    imports LIST

    syntax KItem ::=  "convert" "(" List ")" 
endmodule

module TEST
    imports TEST-SYNTAX
    imports MINT
    imports STRING

    configuration 
    <T>
      <k> convert($ARGV:List) </k>
      <store> 0 </store>
    </T>

    rule <k> convert(.List)   => . 
    ...</k>

    rule <k> convert(ListItem(S:String) Rest:List)   => convert(Rest)
    ...</k>
    <store> N => N +Int lengthString(S) </store>

    
endmodule
