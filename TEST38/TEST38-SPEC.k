module TEST38-SPEC
  imports TEST38

rule
  <k>
    //execinstr (vmovdqa  %ymm0, %ymm0 , .Typedoperands ) => .
    execinstr (xchg  %ymm0, %ymm1 , .Typedoperands ) => .
  </k>
  <state> 
    "RAX" |->  (mi(64, I1:Int) => _)
    "RBX" |->  (mi(64, I2:Int) => _)
    "YMM0" |-> (mi(256, I3:Int) => _)
    "YMM1" |-> (mi(256, I4:Int) => _)
  </state>


endmodule
