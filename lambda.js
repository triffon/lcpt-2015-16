repeat = function(n,f,x) {
    if (n == 0)
        return x;
    else
        return f(repeat(n-1,f,x));
}

succ = function(n) { return n + 1; }

c = function(n) {
    return function(f) {
        return function (x) {
            return repeat(n,f,x);
        }
    }
}

print = function(c) {
    return c(succ)(0);
}

cSucc = function (n) {
    return function (f) {
        return function (x) {
            return f(n(f)(x));
        }}}

succTest = print(cSucc(c(5)))

cPlus = function (m) {
    return function (n) {
        return function (f) {
            return function (x) {
                return m(f)(n(f)(x));
            }}}}

plusTest = print(cPlus(c(5))(c(8)))

cPlus2 = function (m) {
    return function (n) {
        return m(cSucc)(n);
    }}

plus2Test = print(cPlus2(c(5))(c(8)))

cMult2 = function (m) {
    return function (n) {
        return m(cPlus(n))(c(0));
    }}

mult2Test = print(cMult2(c(5))(c(8)))

cMult = function (m) {
    return function (n) {
        return function (f) {
            return m(n(f));
        }}}

multTest = print(cMult(c(5))(c(8)))

cExp2 = function (m) {
    return function (n) {
        return n(cMult(m))(c(1));
    }}

exp2Test = print(cExp2(c(2))(c(5)))

cExp = function (m) {
    return function (n) {
        return n(m);
    }}

expTest = print(cExp(c(2))(c(5)))

cTrue = function (x) {
    return function (y) {
        return x;
    }}

cFalse = function (x) {
    return function (y) {
        return y;
    }}

cIf = function (x) {
    return x;
}

ifTest1 = print(cIf(cTrue)(c(5))(c(7)))
ifTest2 = print(cIf(cFalse)(c(5))(c(7)))

cIsZero = function (n) {
    return n(function(x) { return cFalse; })(cTrue);
}

isZeroTest1 = print(cIf(cIsZero(c(0)))(c(5))(c(7)))
isZeroTest2 = print(cIf(cIsZero(c(10)))(c(5))(c(7)))

printBool = function (b) {
    return b(true)(false);
}

printBoolTest1 = printBool(cIsZero(c(0)))
printBoolTest2 = printBool(cIsZero(c(10)))

cNeg = function (p) {
    return p(cFalse)(cTrue);
}

negTest1 = printBool(cNeg(cTrue))
negTest2 = printBool(cNeg(cFalse))

cAnd = function (p) {
    return function (q) {
        return q(p)(cFalse);
    }}

andTest = printBool(cAnd(cTrue)(cFalse))

cOr = function (p) {
    return function (q) {
        return q(cTrue)(p);
    }}

orTest = printBool(cOr(cTrue)(cFalse))

fact = function (n) {
    if (n == 0)
        return 1;
    else
        return n * fact(n-1);
}

cPair = function (x) {
    return function (y) {
        return function (z) {
            return z(x)(y);
        }}}

cLeft = function (t) {
    return t(cTrue);
}

cRight = function (t) {
    return t(cFalse);
}

pairtTest1 = print(cLeft(cPair(c(4))(cTrue)))
pairtTest2 = printBool(cRight(cPair(c(4))(cTrue)))

createPair = function (x) {
    return function (y) {
        return [print(x), print(y)]; }}

printPair = function (t) {
    return t(createPair);
}

printPairTest = printPair(cPair(c(4))(c(10)))

cPred = function (n) {
    return cRight(
        n
        (function(t) {
            return cPair
            (cSucc(cLeft(t)))
            (cLeft(t));
        })
        (cPair(c(0))(c(0))));
}

predTest1 = print(cPred(c(10)))
predTest2 = print(cPred(c(0)))

cFact = function (n) {
    return cRight(
        n
        (function(t) {
            return cPair
            (cSucc(cLeft(t)))
            (cMult(cSucc(cLeft(t)))(cRight(t)));
        })
        (cPair(c(0))(c(1))));
}

factTest = print(cFact(c(7)))

Y = function (F) {
    wF = function (x) { return F(x(x)); }
    return wF(wF);
}

Fact = function (f) {
    return function (n) {
        return cIsZero(n)(c(1))(cMult(n)(f(cPred(n))));
    }}

omega = function (x) { return x(x); }
    
// Omega = omega(omega)

omega2 = function (x) {
    return function (y) {
        return x(x)(y);
    }}

Y2 = function (F) {
    wF2 = function (x) {
        return F(
            function (y) {
                return x(x)(y);
            });
    };
    return wF2(wF2);
}

Fact2 = function (f) {
    return function (n) {
        return cIsZero(n)
        (c(1))
        (function (y) { return cMult(n)(f(cPred(n)))(y); })
    }}

YTest = print(Y2(Fact2)(c(7)))
