# THESE FUNCTIONS PROVIDES VARIOUS SETS OF REPRESENTATIVES
#
# This function compute the set T of representatives for ideal classes for
# the order of discriminant D in K = Q(sqrt(D))
# INPUT: a discriminant D<0
# OUTPUT: the set of representatives T
def representatives(D):
    a = 1
    if D == -3:
        return []
    T = []
    while 3*(a**2) <= abs(D):
        for b in range(-a,a+1):
            if mod(b**2 - D, 4*a) == 0:
                c = (b**2 - D)/(4*a)
                if a <= c and gcd(a,gcd(b,c)) == 1:
                    if a == abs(b) or a == c:
                        if b >= 0:
                            T.append((-b + sqrt(D))/(2*a))
                    else:
                        T.append((-b + sqrt(D))/(2*a))
        a = a + 1
    return T

# This function computes the minimal polynomial of any imaginary quadratic tau
# INPUT: tau
# OUTPUT: [A, B, C] such that A*tau**2 + B*tau * C = 0, gcd(A, B, C) = 1
def min_poli(tau):
    t = 2*real(tau)
    N = real(tau)**2 + imag(tau)**2
    m = lcm(denominator(t),denominator(N))
    A = m
    B = t*m
    C = N*m
    return [A, -B, C]


# INPUT: tau in H
# OUTPUT: tau* in H such that j(tau) = gamma(tau*)
def find_rep(tau):
    list = min_poli(tau)
    A = ZZ(list[0])
    B = ZZ(list[1])
    C = ZZ(list[2])
    # Forcing A to be not divisible by 3
    if mod(A, 3) == 0:
        if mod(C, 3) == 0:
            A = A + B + C
            B = 2*C + B
        else:
            z = A
            A = C
            B = -B
            C = z
    # find the right tau: A != 0 (mod 3), B = 0 (mod 3), C != 0 (mod 3)
    while mod(B, 3) != 0:
        C = A - B + C
        B = B - 2*A
    return A, B, C

# This function computes the set L
# INPUT: a discriminant D<0
# OUTPUT: 'ERROR' if 3|D, L otherwisese
def gamma_rep(D):
    L = []
    if mod(D, 3) == 0:
        return 'ERRORE'
    lista = representatives(D)
    for tau in lista:
        A, B, C = find_rep(tau)
        tau = -B/(2*A) + sqrt(B**2 - 4*A*C)/(2*A)
        L.append(tau)
    return L

