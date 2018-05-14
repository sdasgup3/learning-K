// Passing List
module TEST41-SYNTAX
    imports LIST

    syntax Task ::=  "inittask"
    syntax Task ::=  "task" "(" List ")" 
    syntax KItem ::=  "config" "(" List ")" 
endmodule

module TEST41
    imports TEST41-SYNTAX
    imports MINT
    imports STRING

    configuration 
    <T>
    //<k> $PGM:Task ~> convert($ARGV:List) </k>
      <k> $PGM:Task </k>
      <store> 0 </store>
    </T>

    rule <k> inittask => task( ListItem("apple") ListItem("mango") .List)  
    ...</k>
    
    rule <k> task(.List)   => . 
    ...</k>

    rule <k> task(ListItem(S:String) Rest:List)   => task(Rest)
    ...</k>
    <store> N => N +Int lengthString(S) </store>

    
endmodule
