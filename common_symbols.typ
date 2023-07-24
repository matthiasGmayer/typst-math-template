#let comp(cont) = $overline(cont)$
#let functionOf = sym.lt.tilde
#let given = $|$

#let PA="PA"

#let XF = $cal(X)$
#let YF = $cal(Y)$
#let ZF = $cal(Z)$
#let WF = $cal(W)$
#let strikethrough = $#h(-0.65em) \/ #h(0.5em)$
#let generates = sym.tack
// #let generatesNot = $generates
// #line(angle: -50deg, start:(-0.93em,0.5em),length:0.88em ,stroke:0.04em)
// #h(-0.34em)$
#let generatesNot = math.op("⊬")
#let history = $cal(H)$
#let perpNot =  $perp strikethrough$
#let disintegrates = math.op(sym.times.div)
#let disintegratesNot = $times.div strikethrough$

#let powerset(cont) = $cal(P)(cont)$
#let AS = $cal(A)$
#let BS = $cal(B)$
#let CS = $cal(C)$
#let DS = $cal(D)$
#let borel = $cal(B)$
#let probvec = $cal(v)$
#let probvecs = $cal(V)$
#let one = $bb(1)$
#let distributions = math.op(sym.triangle.t)
#let distributionsF = $distributions^*$
#let nullset = $cal(N)$
#let TS = math.cal("T")
#let id = math.op("id")
#let do= math.op("do")
#let Irr(A) = $I^(#A)$
#let partitions=math.op("part")
#let support=math.op("supp")
#let terms=math.op("terms")
#let var=math.op("var")
#let eval=math.op("eval")
#let pa=math.op("pa")

#let intervenable = math.op(sym.arrow.r.twohead.bar)
#let intervenableNot = math.cancel(intervenable, length:100%,stroke:0.05em)

// #intervenable

// #intervenableNot

#let causeOf= math.op(sym.arrow.r.twohead)
#let xor = math.op(sym.plus.circle)

// #let res(f,c) = f + sym.bar.v + $""_#c$
#let res(f,c) = $#f\|""_#c$
#let funindSymbol = "f"
#let funind = $attach(perp,br:funindSymbol)$
// #let test= $cancel(x)$

#let path = sym.arrow.long.bar
#let upath = sym.arrow.dashed
#let ancestors = math.op(sym.Alpha)

// #generatesNot

#let prime = move(dx: 0.05em, dy: 0.375em, scale("\u{2032}", x:150%,y : 150%))

#let test = symbol("⊬")
#let t = "⊬"
Math: $tack, test$, normal #sym.tack  #t
