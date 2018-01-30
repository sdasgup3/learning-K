requires "domains.k"

// kprove runtime


module TEST34-SYNTAX
    imports MINT
    syntax Task ::=  "task"
    syntax Tasks ::= List{Task, ""} [klabel(tasklist)]

endmodule

module TEST34
    imports TEST34-SYNTAX

    configuration 
    <T>
    <k>$PGM:Tasks</k>
    <state> 
    .Map
    /*
      ("RAX" |->    mi(64,  0 :Int))
      ("RBX" |->    mi(64,  0 :Int))
      ("RCX" |->    mi(64,  0 :Int))
      ("RDX" |->    mi(64,  0 :Int))
      ("RSI" |->    mi(64,  0 :Int))
      ("RDI" |->    mi(64,  0 :Int))
      ("RSP" |->    mi(64,  0 :Int))
      ("RBP" |->    mi(64,  0 :Int))
      ("R8"  |->    mi(64,  0 :Int))
      ("R9"  |->    mi(64,  0 :Int))
      ("R10" |->    mi(64,  0 :Int))
      ("R11" |->    mi(64,  0 :Int))
      ("R12" |->    mi(64,  0 :Int))
      ("R13" |->    mi(64,  0 :Int))
      ("R14" |->    mi(64,  0 :Int))
      ("R15" |->    mi(64,  0 :Int))
      ("CF" |->     mi(1,   0 :Int))
      ("PF" |->     mi(1,   0 :Int))
      ("AF" |->     mi(1,   0 :Int))
      ("ZF" |->     mi(1,   0 :Int))
      ("SF" |->     mi(1,   0 :Int))
      ("OF" |->     mi(1,   0 :Int))
      ("YMM0"  |->  mi(256, 0 :Int))
      ("YMM1"  |->  mi(256, 0 :Int))
      ("YMM2"  |->  mi(256, 0 :Int))
      ("YMM3"  |->  mi(256, 0 :Int))
      ("YMM4"  |->  mi(256, 0 :Int))
      ("YMM5"  |->  mi(256, 0 :Int))
      ("YMM6"  |->  mi(256, 0 :Int))
      ("YMM7"  |->  mi(256, 0 :Int))
      ("YMM8"  |->  mi(256, 0 :Int))
      ("YMM9"  |->  mi(256, 0 :Int))
      ("YMM10" |->  mi(256, 0 :Int))
      ("YMM11" |->  mi(256, 0 :Int))
      ("YMM12" |->  mi(256, 0 :Int))
      ("YMM13" |->  mi(256, 0 :Int))
      ("YMM14" |->  mi(256, 0 :Int))
      ("YMM15" |->  mi(256, 0 :Int))
*/
    </state>
    </T>


    rule T:Task Ts:Tasks => T ~> Ts
    syntax Map ::= "stubbyFrom" [function]
    syntax Map ::= "stubbyTo" [function]

    //rule stubbyFrom =>  .Map["RAX" <- ( mi(64,?I1:Int)  )]
    rule stubbyFrom =>  
      ("RAX" |->    (mi(64,  ?I1 :Int):MInt)) 
      ("RBX" |->    (mi(64,  ?I2 :Int):MInt)) 
      ("RCX" |->    (mi(64,  ?I3 :Int):MInt))
      ("RDX" |->    (mi(64,  ?I4 :Int):MInt))
      ("RSI" |->    (mi(64,  ?I5 :Int):MInt))
      ("RDI" |->    (mi(64,  ?I6 :Int):MInt))
      ("RSP" |->    (mi(64,  ?I7 :Int):MInt))
      ("RBP" |->    (mi(64,  ?I8 :Int):MInt))
      ("R8"  |->    (mi(64,  ?I9 :Int):MInt))
      ("R9"  |->    (mi(64,  ?I10:Int):MInt))
      ("R10" |->    (mi(64,  ?I11:Int):MInt))
      ("R11" |->    (mi(64,  ?I12:Int):MInt))
      ("R12" |->    (mi(64,  ?I13:Int):MInt))
      ("R13" |->    (mi(64,  ?I14:Int):MInt))
      ("R14" |->    (mi(64,  ?I15:Int):MInt))
      ("R15" |->    (mi(64,  ?I16:Int):MInt))
      ("CF" |->     (mi(1,   ?I17:Int):MInt))
      ("PF" |->     (mi(1,   ?I18:Int):MInt))
      ("AF" |->     (mi(1,   ?I19:Int):MInt))
      ("ZF" |->     (mi(1,   ?I20:Int):MInt))
      ("SF" |->     (mi(1,   ?I21:Int):MInt))
      ("OF" |->     (mi(1,   ?I22:Int):MInt))
      ("YMM0"  |->  (mi(256, ?I23:Int):MInt))
      ("YMM1"  |->  (mi(256, ?I24:Int):MInt))
      ("YMM2"  |->  (mi(256, ?I25:Int):MInt))
      ("YMM3"  |->  (mi(256, ?I26:Int):MInt))
      ("YMM4"  |->  (mi(256, ?I27:Int):MInt))
      ("YMM5"  |->  (mi(256, ?I28:Int):MInt))
      ("YMM6"  |->  (mi(256, ?I29:Int):MInt))
      ("YMM7"  |->  (mi(256, ?I30:Int):MInt))
      ("YMM8"  |->  (mi(256, ?I31:Int):MInt))
      ("YMM9"  |->  (mi(256, ?I32:Int):MInt))
      ("YMM10" |->  (mi(256, ?I33:Int):MInt))
      ("YMM11" |->  (mi(256, ?I34:Int):MInt))
      ("YMM12" |->  (mi(256, ?I35:Int):MInt))
      ("YMM13" |->  (mi(256, ?I36:Int):MInt))
      ("YMM14" |->  (mi(256, ?I37:Int):MInt))
      ("YMM15" |->  (mi(256, ?I38:Int):MInt))

    rule stubbyTo =>  
      ("RAX" |-> ?_) 
      ("RBX" |-> ?_) 
      ("RCX" |-> ?_)
      ("RDX" |-> ?_)
      ("RSI" |-> ?_)
      ("RDI" |-> ?_)
      ("RSP" |-> ?_)
      ("RBP" |-> ?_)
      ("R8"  |-> ?_)
      ("R9"  |-> ?_)
      ("R10" |-> ?_)
      ("R11" |-> ?_)
      ("R12" |-> ?_)
      ("R13" |-> ?_)
      ("R14" |-> ?_)
      ("R15" |-> ?_)
      ("CF" |->  ?_)
      ("PF" |->  ?_)
      ("AF" |->  ?_)
      ("ZF" |->  ?_)
      ("SF" |->  ?_)
      ("OF" |->  ?_)
      ("YMM0"  |->  ?_)
      ("YMM1"  |->  ?_)
      ("YMM2"  |->  ?_)
      ("YMM3"  |->  ?_)
      ("YMM4"  |->  ?_)
      ("YMM5"  |->  ?_)
      ("YMM6"  |->  ?_)
      ("YMM7"  |->  ?_)
      ("YMM8"  |->  ?_)
      ("YMM9"  |->  ?_)
      ("YMM10" |->  ?_)
      ("YMM11" |->  ?_)
      ("YMM12" |->  ?_)
      ("YMM13" |->  ?_)
      ("YMM14" |->  ?_)
      ("YMM15" |->  ?_)

    rule <k> task => . 
    ...</k>
      <state> ...
      "RAX" |->      (MI1 =>  addMInt(MI1,  mi(64, 1)))
      "RBX" |->      (MI2 =>  addMInt(MI2,  mi(64, 2)))
      /*
      "RCX" |->      (MI3 =>  addMInt(MI3,  mi(64, 3)))
      "RDX" |->      (MI4 =>  addMInt(MI4,  mi(64, 4)))
      "RSI" |->      (MI5 =>  addMInt(MI5,  mi(64, 5)))
      "RDI" |->      (MI6 =>  addMInt(MI6,  mi(64, 6)))
      "RSP" |->      (MI7 =>  addMInt(MI7,  mi(64, 7)))
      "RBP" |->      (MI8 =>  addMInt(MI8,  mi(64, 8)))
      "R8"  |->      (MI9 =>  addMInt(MI9,  mi(64, 9)))
      "R9"  |->      (MI10 => addMInt(MI10, mi(64, 10)))
      "R10" |->      (MI11 => addMInt(MI11, mi(64, 11)))
      "R11" |->      (MI12 => addMInt(MI12, mi(64, 12)))
      "R12" |->      (MI13 => addMInt(MI13, mi(64, 13)))
      "R13" |->      (MI14 => addMInt(MI14, mi(64, 14)))
      "R14" |->      (MI15 => addMInt(MI15, mi(64, 15)))
      "R15" |->      (MI16 => addMInt(MI16, mi(64, 16)))
      "CF" |->       (MI17 => addMInt(MI17, mi(1, 0)))
      "PF" |->       (MI18 => addMInt(MI18, mi(1, 0)))
      "AF" |->       (MI19 => addMInt(MI19, mi(1, 0)))
      "ZF" |->       (MI20 => addMInt(MI20, mi(1, 0)))
      "SF" |->       (MI21 => addMInt(MI21, mi(1, 0)))
      "OF" |->       (MI22 => addMInt(MI22, mi(1, 0)))

      "YMM0"  |->  ( MI23 => addMInt(MI23, mi(256, 1)))
      "YMM1"  |->  ( MI24 => addMInt(MI24, mi(256, 2)))
      "YMM2"  |->  ( MI25 => addMInt(MI25, mi(256, 3)))
      "YMM3"  |->  ( MI26 => addMInt(MI26, mi(256, 4)))
      "YMM4"  |->  ( MI27 => addMInt(MI27, mi(256, 5)))
      "YMM5"  |->  ( MI28 => addMInt(MI28, mi(256, 6)))
      "YMM6"  |->  ( MI29 => addMInt(MI29, mi(256, 7)))
      "YMM7"  |->  ( MI30 => addMInt(MI30, mi(256, 8)))
      "YMM8"  |->  ( MI31 => addMInt(MI31, mi(256, 9)))
      "YMM9"  |->  ( MI32 => addMInt(MI32, mi(256, 10)))
      "YMM10" |->  ( MI33 => addMInt(MI33, mi(256, 11)))
      "YMM11" |->  ( MI34 => addMInt(MI34, mi(256, 12)))
      "YMM12" |->  ( MI35 => addMInt(MI35, mi(256, 13)))
      "YMM13" |->  ( MI36 => addMInt(MI36, mi(256, 14)))
      "YMM14" |->  ( MI37 => addMInt(MI37, mi(256, 15)))
      "YMM15" |->  ( MI38 => addMInt(MI38, mi(256, 16)))
      */


      ...  </state>

endmodule

