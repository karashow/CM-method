load('cornacchia.sage')
load('classpoly.sage')
load('functions.sage')

# CM elliptic curve with a prescribed number of rational points
# INPUT: an integer N
# OTPUT: a prime p and an elliptic curve defined over GF(p) with N F_p-rational points

# 1. This uses the SageMath's function 'hilbert_class_polynomial'
def CMM(N):
    trovato = False
    D = -4
    while not trovato:
        D = next_discriminant(D)
        x = cornacchia(-D, 4 * N)
        if len(x) == 2:
            a = x[0]
            v = x[1]
            t = a + 2
            p = N - 1 + t
            if is_prime(p):
                trovato = True
    d = fundamental_discriminant(D)
    if d != -3 and d != 4:
        D = d
    H = hilbert_class_polynomial(D)
    R = PolynomialRing(GF(p),'x')
    x = R.gen()
    F = factor(H(x))
    j = F[0][0]
    j = -j(0)
    A = mod( 3 * j * (1728 - j), p)
    B = mod( 2 * j * ((1728 - j)**2), p)
    E = EllipticCurve(GF(p), [A,B])
    if N < 65:
        if E.cardinality() == N:
            return E
        else:
            return E.quadratic_twist()
    infinity = E(0)
    P = infinity
    Q = infinity
    while P == infinity and Q == infinity:
        R = E.random_element()
        P = (p + 1 - t) * R
        Q = (p + 1 + t) * R
    if P == infinity:
        return E
    else:
        return E.quadratic_twist()

# 2. This uses my hilbert_poly and gamma_poly functions
def myCMM(N):
    trovato = False
    D = -4
    while not trovato:
        D = next_discriminant(D)
        x = cornacchia(-D, 4 * N)
        if len(x) == 2:
            a = x[0]
            v = x[1]
            t = a + 2
            p = N - 1 + t
            if is_prime(p):
                trovato = True
    d = fundamental_discriminant(D)
    if d != -3 and d != -4:
        D = d
    if mod(D, 3) == 0:
        H = hilbert_poly(D)
    else:
        H = gamma_poly(D)
    R = PolynomialRing(GF(p),'x')
    H = R(H)
    if mod(D, 3) == 0:
        j = H.any_root()
    else:
        j = H.any_root()
        j = j**3
    A = mod( 3 * j * (1728 - j), p)
    B = mod( 2 * j * ((1728 - j)**2), p)
    E = EllipticCurve(GF(p), [A,B])
    if N < 65:
        if E.cardinality() == N:
            return E
        else:
            return E.quadratic_twist()
    infinity = E(0)
    P = infinity
    Q = infinity
    while P == infinity and Q == infinity:
        R = E.random_element()
        P = (p + 1 - t) * R
        Q = (p + 1 + t) * R
    if P == infinity:
        return E
    else:
        return E.quadratic_twist()





