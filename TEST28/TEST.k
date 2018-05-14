module TEST28-SYNTAX
    imports DOMAINS-SYNTAX
    syntax Task ::=  "task" "(" String ","  Int ")"
      | "task2" "(" Int "," Int ")"
      | "task3" "(" Int "," Int ")"

    syntax Tasks ::= List{Task, ""} [klabel(tasklist)]

endmodule

module TEST28
    imports TEST28-SYNTAX
    imports DOMAINS
    imports MINT

    configuration 
    <T>
      <k> $PGM:Tasks </k>
      <state> 
        ("RSP" |-> ?I1:MInt)
        ("RBP" |-> ?I2:MInt)
      </state>

      <result> .List </result>
    </T>

    rule T:Task Ts:Tasks => T ~> Ts

    rule <k> task(R, I) => .
    ...</k>
      <state>... "RSP" |-> (MI => addMInt(MI, mi(64, I))) ...</state>
        requires R ==String "RSP"

    rule <k> task(R, I) => .
    ...</k>
      <state>... "RBP" |-> (MI => addMInt(MI, mi(64, I))) ...</state>
        requires R ==String "RBP"

    /*@
      Requires both the arguments to be the same
    */   
    rule <k> task2(I,I) => .
    ...</k>  
      <result>... .List => ListItem("both same")</result>


    /*@
      Requires both the arguments to be the same/or diff
      same effect for task2(_, _)
    */   
    rule <k> task2(I,J) => .
    ...</k>  
      <result>... .List => ListItem("both same/or diff")</result>
  

    rule <k> task3(?_, ?_) => .
    ...</k>  
    <result>... .List => ListItem("both same")</result>


endmodule
