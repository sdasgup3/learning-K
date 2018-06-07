// krun '-cARGV0=store("rax", mi(64, 0)) store("rbx", mi(64, 1))'      TEST.test

module TEST-SYNTAX
    imports MAP
    imports INT
    imports MINT
    imports STRING
    syntax Task ::= "task" "(" Int ")" 
    syntax Store ::= "store" "(" String "," MInt ")" 
    syntax StoreList ::= List{Store, ""}

endmodule

module TEST
    imports TEST-SYNTAX

    configuration 
      <k> $PGM:Task </k>
      <reginput> $ARGV0:StoreList </reginput>
      <regstate> .Map </regstate>

    rule <k>  
    task(I:Int) => populateMap(X) ~> .
    ...</k>
    <reginput> X:StoreList </reginput>



    syntax Kitem ::= populateMap(StoreList)

    rule <k>
      populateMap(.StoreList) => .
    </k>

    rule <k>
      populateMap(store(P, Q ) Rest:StoreList) => populateMap(Rest)
    </k>
      <regstate>...  .Map => P |-> Q    ...</regstate>

endmodule
