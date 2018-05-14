requires "domains.k"

module TEST18-SYNTAX
    imports DOMAINS-SYNTAX
    syntax Task ::=  "cvtdq2pd" "(" Int "," Int ")" [function]
         | "cvtdq2ps" "(" Int "," Int ")" [function]
         | "cvtps2pd" "(" Int "," Int "," Int ")" [function]
         | "cvtps2dq" "(" Int "," Int "," Int ")" [function]
         | "testSplitJoin" "(" Int "," Int ")" [function]

    syntax Tasks ::= List{Task, ""} 
endmodule

module TEST18
    imports TEST18-SYNTAX
    imports DOMAINS
    imports MINT
    imports FLOAT

    configuration <k>$PGM:Tasks</k>

    rule T:Task Ts:Tasks => T ~> Ts


    syntax MInts ::= List{MInt, ""} [klabel(mintlist)]
    syntax Floats ::= List{Float, ""} [klabel(floatlist)]
    syntax Ints ::= List{Int, ""} [klabel(intlist)]

    syntax MInts ::= splitVector(MInt, Int) [function]
    syntax MInts ::= splitVectorHelper(MInt, Int, Int) [function]
    syntax MInt ::= joinVector(MInts) [function]

    rule splitVector(MI, W) => splitVectorHelper(MI, W, 0)
      requires bitwidthMInt(MI) >=Int W andBool 0 =/=Int W
    rule splitVector(MI, W) => .MInts 
      requires bitwidthMInt(MI) <Int W orBool 0 ==Int W

    rule splitVectorHelper(MI, W, P) => extractMInt(MI, P, P +Int W) splitVectorHelper(MI, W, P +Int W)
      requires bitwidthMInt(MI) >Int P
    
    rule splitVectorHelper(MI, W, P) => .MInts
      requires bitwidthMInt(MI) ==Int P

     rule joinVector(MI:MInt Rest) => MI
    requires Rest ==K .MInts                   

  rule joinVector(MI:MInt Rest) => concatenateMInt(MI, joinVector(Rest))
    requires Rest =/=K .MInts       

    syntax Ints ::= convertMIntsToSInts(MInts) [function]
    rule convertMIntsToSInts(MI MIs) => svalueMInt(MI) convertMIntsToSInts(MIs)
    rule convertMIntsToSInts(.MInts) => .Ints

    syntax Floats ::= convertMIntsToFps(MInts, Int, Int) [function]
    rule convertMIntsToFps(MI MIs, P, E) => MInt2Float(MI, P, E) convertMIntsToFps(MIs, P, E)
    rule convertMIntsToFps(.MInts, _, _) => .Floats

    syntax Floats ::= convertIntsToFps(Ints, Int, Int) [function]
    rule convertIntsToFps(I Is, P, E) => Int2Float(I, P, E) convertIntsToFps(Is, P, E)
    rule convertIntsToFps(.Ints, _, _) => .Floats

    syntax MInts ::= convertFpsToMints(Floats, Int) [function]
    rule convertFpsToMints(F Fs, W) => Float2MInt(F, W) convertFpsToMints(Fs, W)
    rule convertFpsToMints(.Floats, _) => .MInts

    syntax Ints ::= convertFpsToInts(Floats) [function]
    rule convertFpsToInts(F Fs) => Float2Int(F) convertFpsToInts(Fs)
    rule convertFpsToInts(.Floats) => .Ints

    syntax MInts ::= convertIntsToMInts(Ints, Int) [function]
    rule convertIntsToMInts(I Is, W) => mi(I, W) convertIntsToMInts(Is, W)
    rule convertIntsToMInts(.Ints, _) => .MInts

    syntax Floats ::= convertFloatsToDoubles(Floats) [function]
    rule convertFloatsToDoubles(F Fs) => Float2Double(F) convertFloatsToDoubles(Fs)
    rule convertFloatsToDoubles(.Floats) => .Floats

    //syntax Floats ::= convertDoublesToFloats(Floats) [function]
    //rule convertDoublesToFloats(F Fs) => Double2Float(F) convertFp32sToFp64s(Fs)
    //rule convertDoublesToFloats(.Floats) => .Floats

    // double word to PS/PD
    rule cvtdq2pd(I, IW) =>  joinVector(convertFpsToMints(convertIntsToFps(convertMIntsToSInts(splitVector(mi(IW,I), 32)), 53, 11), 64))
    rule cvtdq2ps(I, IW) =>  joinVector(convertFpsToMints(convertIntsToFps(convertMIntsToSInts(splitVector(mi(IW,I), 32)), 24, 8), 32))

    // PS <-> PD
    rule cvtps2pd(I, IW, T) =>  eqMInt(mi( 2*Int IW, T), joinVector(convertFpsToMints(convertFloatsToDoubles(convertMIntsToFps(splitVector(mi(IW,I), 32), 24, 8)), 64)))

    //rule cvtpd2ps(I, IW) => 
    //rule testSplitJoin(I, IW) => joinVector(splitVector(mi(IW,I), 32))

    // PD/PS -> double word
    // rule cvtpd2dq(I, IW) => 
    //rule cvtps2dq(I, IW, T) =>  convertIntsToMInts(convertFpsToInts(convertMIntsToFps(splitVector(mi(IW,I), 32), 24, 8)), 32)


    // rule cvttps2dq(I, IW) => 
    // rule cvttpd2dq(I, IW) => 


endmodule


















