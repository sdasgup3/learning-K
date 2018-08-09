module MINT
  imports INT
  imports K-EQUAL

  /*@ Machine integer of bit width and value. */
  syntax MInt ::= mi(Int, Int) [function]

  /*@
   * Shift operations; the second operand must be non-negative
   *
   * ashrMInt   arithmetic shift: filling with leftmost bit (sign extension)
   * lshrMInt   logical shift: filling with zeros
   */
  syntax MInt ::= shlMInt(MInt, Int)    [function, smtlib(bvshl)]
                | ashrMInt(MInt, Int)   [function]
                | lshrMInt(MInt, Int)   [function, smtlib(bvlshr)]



  /*@ Bitwise operations */
  syntax MInt ::= andMInt(MInt, MInt)   [function,  smtlib(bvand)]
                | orMInt(MInt, MInt)    [function,  smtlib(bvor)]
                | xorMInt(MInt, MInt)   [function,  smtlib(bvxor)]

  rule andMInt(mi(W, I1), mi(W, I2)) => mi(W, I1 &Int I2) 
  rule orMInt(mi(W, I1), mi(W, I2)) => mi(W, I1 |Int I2) 
  rule xorMInt(mi(W, I1), mi(W, I2)) => mi(W, I1 ^Int I2) 

  syntax MInt ::= negMInt(MInt)   [function]
  rule negMInt(MI:MInt) => xorMInt(MI, mi(bitwidthMInt(MI), -1))




  /*@ Function returning the bit width of this machine integer. */
  rule bitwidthMInt(addMInt(MIC,  _)) => bitwidthMInt(MIC) [lemma]
  rule bitwidthMInt(xorMInt(MIC,  _)) => bitwidthMInt(MIC) [lemma]
  rule bitwidthMInt(orMInt(MIC,   _)) => bitwidthMInt(MIC) [lemma]
  rule bitwidthMInt(andMInt(MIC,  _)) => bitwidthMInt(MIC) [lemma]
  rule bitwidthMInt(mulMInt(MIC,  _)) => bitwidthMInt(MIC) [lemma]
  rule bitwidthMInt(lshrMInt(MIC, _)) => bitwidthMInt(MIC) [lemma]
  rule bitwidthMInt(ashrMInt(MIC, _)) => bitwidthMInt(MIC) [lemma]
  rule bitwidthMInt(shlMInt(MIC,  _)) => bitwidthMInt(MIC) [lemma]
  rule bitwidthMInt(negMInt(MIC))     => bitwidthMInt(MIC) [lemma]
  rule bitwidthMInt(concatenateMInt(MI1:MInt, MI2:MInt)) => bitwidthMInt(MI1) +Int bitwidthMInt(MI2) [lemma]
  rule bitwidthMInt(#ifMInt B:Bool #then MI1 #else MI2 #fi) => bitwidthMInt(MI1) [lemma]
  rule bitwidthMInt(Float2MInt(_:Float, W:Int)) => W [lemma]

  // Base Rules
  rule bitwidthMInt(mi(W:Int, _)) => W [lemma]
  rule bitwidthMInt(extractMask(_, W:Int, _)) => W [lemma]
  rule bitwidthMInt(extractMInt(_, S:Int, E:Int)) => E -Int S [lemma]
  rule bitwidthMInt(zeroExtend(_:MInt, W:Int)) => W [lemma]
  rule bitwidthMInt(signExtend(_:MInt, W:Int)) => W [lemma]


  
	
  syntax MInt ::= addMInt(MInt, MInt)   [function, smtlib(bvadd)]

  syntax MInt ::= chop(MInt) [function]
  rule chop(mi(W, I)) => mi(W, I %Int (2 ^Int W))
  rule addMInt(bv(W, I1), bv(W, I2)) => chop(bv(W, (I1 +Int I2)))
endmodule
