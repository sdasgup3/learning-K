// krun  '-cARGV=`_List_`(`ListItem`(#token("\"apple\"","String@STRING-SYNTAX")),`_List_`(`ListItem`(#token("\"mango\"","String@STRING-SYNTAX")),`.List`(.KList))))))' '-pARGV=printf %s'  |& tee TEST.test.out

// Passing List
module TEST-SYNTAX
    imports LIST

    syntax KItem ::=  "config" "(" List ")" 
endmodule

module TEST
    imports TEST-SYNTAX
    imports MINT
    imports STRING

    configuration 
    <T>
    <k> config($ARGV:List) </k>
      <store> 0 </store>
    </T>

endmodule
