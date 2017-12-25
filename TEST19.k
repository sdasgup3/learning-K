requires "domains.k"

module TEST19-SYNTAX
    imports MINT
    syntax Task ::=  "test" "(" Int "," Int ")" 
            | "inforreg" 

    syntax Tasks ::= List{Task, ""} [klabel(tasklist)]

endmodule

module TEST19
    imports TEST19-SYNTAX

    configuration 
    <T>
      <k>$PGM:Tasks</k>

      <regstate>  
        <gpr>
          <rax> 1 </rax>
        </gpr>

        <flag>
          <cf> 2 </cf>
        </flag>
      </regstate>

      <regstatequeue> .List </regstatequeue>
    </T>

    rule T:Task Ts:Tasks => T ~> Ts

    rule <k> test(I, J) => .K ...</k>
    <rax> _ => I </rax>
    <cf>  _ => J </cf>

    rule <k> inforreg => .K ...</k>
    <regstatequeue> ... .List => ListItem(REGSTATE)   </regstatequeue>
    <gpr> REGSTATE </gpr>


endmodule
