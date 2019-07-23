// krun '-cARGV0=store("rax", mi(64, 0)) store("rbx", mi(64, 1))'      TEST.test
requires "x86-float-conversions.k"
module TEST-SYNTAX
    imports MINT
    imports FLOAT
    imports BOOL
    imports FLOAT-CONVERSIONS
    syntax MInt ::= "#ifMInt"   Bool "#then" MInt  "#else" MInt  "#fi" [function]
    syntax Task ::= "max" "(" MInt "," MInt ")" [function]
    syntax Task ::= "max2" "(" MInt "," MInt ")" [function]
    syntax Task ::= "maxcmp_single" "(" MInt "," MInt ")" [function]
    syntax Task ::= "mul1" "(" MInt "," MInt  ")" [function]
    syntax Task ::= "mul2" "(" MInt "," MInt ")" [function]
    syntax MInt ::= "vfmadd132_double" "(" MInt "," MInt ")" [function]
    syntax Task ::= "vfnmadd132_single" "(" MInt "," MInt "," MInt ")" [function]
    syntax Task ::= MInt

    syntax Tasks ::= List{Task, ""}

endmodule

module TEST
    imports TEST-SYNTAX

    configuration 
      <k> $PGM:Tasks </k>

    rule <k> T:Task Ts:Tasks => T ~> Ts
    </k>

    rule #ifMInt B #then W #else _ #fi => W requires B
    rule #ifMInt B #then _ #else W #fi => W requires notBool B


     rule maxcmp_single(MI1:MInt, MI2:MInt) => MI2
    requires  isNegativeZero(MInt2Float(MI1, 24, 8))  andBool isPositiveZero(MInt2Float(MI2, 24, 8)) 

  rule maxcmp_single(MI1:MInt, MI2:MInt) => MI1
    requires  isNegativeZero(MInt2Float(MI2, 24, 8))  andBool isPositiveZero(MInt2Float(MI1, 24, 8)) 


  /*
  rule maxcmp_single(MI1:MInt, MI2:MInt) => mi(1, 1)
    requires  isNaN(MInt2Float(MI1, 24, 8))  andBool (notBool isNaN(MInt2Float(MI2, 24, 8)))

  rule maxcmp_single(MI1:MInt, MI2:MInt) => mi(1, 0)
    requires  (notBool isNaN(MInt2Float(MI1, 24, 8)))  andBool  isNaN(MInt2Float(MI2, 24, 8)) 
    */

    rule
    max(MI1:MInt, MI2:MInt) =>  Float2MInt(maxFloat( MInt2Float(MI1, 24, 8),
                                                  MInt2Float(MI2, 24, 8)), 32) 

    rule
    max2(MI1:MInt, MI2:MInt) =>  MI2
      requires isNaN(MInt2Float(MI2, 53, 11))

  rule vfmadd132_double(MI1:MInt,  MI2:MInt) => 
    Float2MInt(
        (MInt2Float(MI1, 53, 11) 
          *Float 
        MInt2Float(MI2, 53, 11)) 

          +Float 
        MInt2Float(mi(64, 0), 53, 11), 64)


    rule vfnmadd132_single(MI1:MInt, MI2:MInt, MI3:MInt) => 
    //Float2MInt((-1.0f *Float (MInt2Float(MI1, 24, 8) *Float MInt2Float(MI3, 24, 8))) +Float MInt2Float(MI2, 24, 8), 32)
    Float2MInt(negateFloat(MInt2Float(MI1, 24, 8) *Float MInt2Float(MI3, 24, 8)) +Float MInt2Float(MI2, 24, 8), 32)
      requires  notBool (notBool eqMInt(MI1, mi(32, 0)) andBool notBool eqMInt(MI3, mi(32, 0)) andBool eqMInt(MI2, mi(32, 0)))

  rule vfnmadd132_single(MI1:MInt, MI2:MInt, MI3:MInt) => 
    //Float2MInt((-1.0f *Float (MInt2Float(MI1, 24, 8) *Float MInt2Float(MI3, 24, 8))), 32)
    Float2MInt(negateFloat(MInt2Float(MI1, 24, 8) *Float MInt2Float(MI3, 24, 8)), 32)
      requires notBool eqMInt(MI1, mi(32, 0)) andBool notBool eqMInt(MI3, mi(32, 0)) andBool eqMInt(MI2 , mi(32, 0))



 rule mul1(MI1:MInt, MI2:MInt) => 
  Float2MInt(
      MInt2Float(MI1, 53, 11) *Float MInt2Float(MI2, 53, 11), 
      64)


 rule mul2(MI1:MInt,  MI2:MInt) =>  vfmadd132_double(MI1, MI2)


endmodule
