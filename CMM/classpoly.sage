# THE HILBERT AND WEBER-GAMMA POLYNOMIALS

load('ModFun.sage')
load('rep.sage')

R.<x> = ZZ[x]

# Parameters:
# INPUT: a discriminant D
# OUTPUT: the required precision for computing H_D(x)
def precision(D):
    prec = 100 + ceil(sqrt(-D)*log(-D)**2)
    return round(prec)

# This function computes the Hilbert class polynomial H_D(x)
# INPUT: a discriminant D
# OUTPUT: H_D(x)
def hilbert_poly(D):
    if not is_a_discrtiminant(D):
        return 'Not a discriminant'
    if D == -4:
        return x - 1728
    if D == -3:
        return x
    prec = precision(D)
    r = 10
    h = 1
    rap = representatives(D)
    for tau in rap:
        h = h*(x - j_inv(tau, r, prec))
    c = h.coefficients()
    h = 0
    for i in range(len(c)):
        val = round(real(c[i][0]))
        h = h + val*(x**i)
    return h

# This function compute the Weber polynomial G_D(x)
# INPUT: a discriminant D
# OUTPUT: If 3|D 'The discriminant must be relatively prime to 3', G_D(x)
def Gamma_poly(D, r, prec):
    if not is_a_discrtiminant(D):
        return 'Not a discriminant'
    if mod(D, 3) == 0:
        return 'The discriminant must be relatively prime to 3'
    if D == -4:
        return x - 12
    g = 1
    rap = gamma_rep(D)
    for tau in rap:
        g = g*(x - gamma(tau, r, prec))
    c = g.coefficients()
    g = 0
    for i in range(len(c)):
        val = round(real(c[i][0]))
        g = g + val*(x**i)
    return g

def gamma_poly(D):
    if not is_a_discrtiminant(D):
        return 'Not a discriminant'
    if mod(D, 3) == 0:
        return 'The discriminant must be relatively prime to 3'
    if D == -4:
        return x - 12
    prec = ceil(RR(precision(D)/3))
    r = 10
    G = Gamma_poly(D, r, prec)
    while not check(G, hilbert_class_polynomial(D)):
        prec = prec + 10
        r = r + 5
        G = Gamma_poly(D, r, prec)
    return G

#################################################################

# OTHER FUNCTIONS

# Check if D is a discriminant
def is_a_discrtiminant(D):
    if mod(D, 4) == 0 or mod(D, 4) == 1:
        return true
    else:
        return false

# Next discriminant
def next_discriminant(D):
    D = D - 1
    while True:
        if mod(D, 4) == 0 or mod(D, 4) == 1:
            return D
        else:
            D = D - 1

# The 'resultant trick': since the roots of H_D(x) are
# the cubes of that of G_D(x)
# therefore Res_x(p(x), t - x^3) = H_D(t)
def check(poly1, poly2):
    R.<x,y> = QQ[]
    gammaCubes = poly1.resultant(y-x^3,x)
    X = gammaCubes.coefficients()
    X.reverse()
    Y = poly2.coefficients()
    if X == Y:
        return true
    else:
        return false
