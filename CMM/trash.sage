def Hilbert_poly(D, r, prec):
    if not is_a_discrtiminant(D):
        return 'Not a discriminant'
    if D == -4:
        return x - 1728
    if D == -3:
        return x
    h = 1
    T = representatives(D)
    for tau in T:
        h = h*(x - j_inv(tau, r, prec))
    c = h.coefficients()
    h = 0
    for i in range(len(c)):
        val = round(real(c[i][0]))
        h = h + val*(x**i)
    return h

def Is_hilb(D, r, prec):
    if D == -4 or D == -3:
        return true
    if is_a_discrtiminant(D):
        if hilbert_poly(D) == hilbert_class_polynomial(D):
            return true
        else:
            return false
    else:
        return 'Not a discriminant'

def Hilb_test(n, r, prec):
    D = -3
    for i in range(n):
        print(D, Is_hilb(D))
        D = next_discriminant(D)

def Print_poly(n):
    r = 20
    prec = 300
    D = -2
    for i in range(n):
        D = next_discriminant(D)
        print('--')
        print('Discriminant:', D)
        print('Hilbert class polynomial:', Hilbert_poly(D, r, prec))
        if mod(D, 3) != 0:
            print('Weber gamma polynomial:', Gamma_poly(D, r, prec))




while not check(G, hilbert_class_polynomial(D)):
    r = r + 5
        G = Gamma_poly(D, r, prec)
