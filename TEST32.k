requires "domains.k"

// changing multiple values of a map

module TEST32-SYNTAX
    imports MINT
    syntax Task ::=  "task" 
                  | "xyz"
    syntax Tasks ::= List{Task, ""} [klabel(tasklist)]

endmodule

module TEST32
    imports TEST32-SYNTAX

    configuration 
    <T>
    <k>$PGM:Tasks</k>
    <state> 
      "AB" |-> mi(64, 0)
      "CD" |-> mi(64, 1)
      "EF" |-> mi(64, 2)
    </state>
    </T>


    rule T:Task Ts:Tasks => T ~> Ts


    rule <k> task => . 
    ...</k>
      <state> ...
            "AB" |->  ( MI1 => addMInt(MI2, mi(64, 3)))
            "CD" |->  ( MI2 => addMInt(MI1, mi(64, 4)))
            ...
      </state>

    rule <k> xyz => . 
    ...</k>
      <state> RSMap => RSMap[ "AB" <- addMInt(RSMap["AB"]:>MInt, mi(64, 30)) ] </state>

                                        
endmodule
