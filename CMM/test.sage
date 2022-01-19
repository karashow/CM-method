# TEST FUNCTIONS & EXPERIMENTS

load('CM_method.sage')

# Check if our hilbert polynomial is correct
#
# 1. rapid test
def is_hilb(D):
    if D == -4 or D == -3:
        return true
    if is_a_discrtiminant(D):
        if hilbert_poly(D) == hilbert_class_polynomial(D):
            return true
        else:
            return false
    else:
        return 'Not a discriminant'

# 2. multiple test: check for all the discriminants smaller than n
def hilb_test(n):
    D = -3
    for i in range(n):
        print(D, is_hilb(D))
        D = next_discriminant(D)

# Check if our weber gamma polynomial is correct
#
# 1. rapid test: check one single discriminant
def is_gamma(D):
    R.<x,y> = QQ[]
    S.<z> = QQ[]
    if D == -4 or D == -3:
        return true
    if mod(D, 3) == 0:
        return 'The discriminant must be relatively prime to 3'
    if is_a_discrtiminant(D):
        hilb = hilbert_class_polynomial(D)
        gamma = gamma_poly(D)
        H2.<a> = NumberField(gamma)
        H.<b> = NumberField(hilb)
        if H.is_isomorphic(H2):
            return true
        else:
            return false
    else:
        return 'Not a discriminant'

# 2. multiple test: check for all the allowed discriminants smaller than n
def gamma_test(n):
    D = -3
    i = 0
    j = 0
    for i in range(n):
        if mod(D, 3) != 0:
            print(D, is_gamma(D))
            if is_gamma(D):
                i = i + 1
            else:
                j = j + 1
        D = next_discriminant(D)


# TESTS FOR THE CM METHOD

# Check if CMM(N) is correct
def test_CMM(N):
    E = CMM(N)
    if E.cardinality() == N:
        return true
    else:
        return false

# Check if myCMM(N) is correct
def test_myCMM(N):
    E = myCMM(N)
    if E.cardinality() == N:
        return true
    else:
        return false

# PRINT POLYNOMIALS AN ELLIPTIC CURVES

# This function prints the first N Hilbert class polynomials
def print_hilbert_poly(n):
    D = -2
    for i in range(n):
        D = next_discriminant(D)
        print('--')
        print('Discriminant:', D)
        print('Hilbert class polynomial:', hilbert_poly(D))
        print('--')

# This function prints the first N Weber gamma class polynomials
def print_gamma_poly(n):
    D = -2
    for i in range(n):
        D = next_discriminant(D)
        if mod(D, 3) != 0:
            print('--')
            print('Discriminant:', D)
            print('Weber gamma class polynomial:', gamma_poly(D))
            print('--')

# This function print both Hilbert and Weber polynomials
def print_poly(n):
    D = -2
    for i in range(n):
        D = next_discriminant(D)
        print('--')
        print('Discriminant:', D)
        print('Hilbert class polynomial:', hilbert_poly(D))
        if mod(D, 3) != 0:
            print('Weber gamma polynomial:', gamma_poly(D))
        print('--')

# Print an elliptic curve generated with CMM(i) for any 3 <= i <= n
def print_curve(n):
    for i in range(3,n+1):
        print('--')
        print('Cardinality:', i)
        print(CMM(i))
    print('--')

# Generator of elliptic curves
def generate_curve():
    N = int(input("Type the desired number of rational point and press ENTER: "))
    E = CMM(N)
    print(E)
