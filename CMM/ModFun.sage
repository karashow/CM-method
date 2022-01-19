# THESE FUNCTIONS EVALUATE SOME MODULAR FORMS
# prec denote the complex floating point precision
# r denote the truncation number of the series

# 1. eta function
def eta(tau, r, prec):
    R = RealField(prec)
    C = R.algebraic_closure()
    q = exp(2*pi*I*tau)
    e = 1
    for i in range(r):
        k = i + 1
        e += ((-1)**k)*(q**(k*(3*k+1)/2) + q**(k*(3*k-1)/2))
    return C(q**(1/24) * e)

# 2. j function
def j_inv(tau, r, prec):
    R = RealField(prec)
    C = R.algebraic_closure()
    q = exp(2 * pi * I * tau)
    a = eta(tau, r, prec)
    b = eta(2 * tau, r, prec)
    return ((a / b)**8 + (2**8) * (b / a)**16)**3

# 3. Eisenstein series
def eisenstein(k, r, tau, prec):
    R = RealField(prec)
    C = R.algebraic_closure()
    E = 1
    q = exp(2*pi*I*tau)
    if r == 0:
        return 1
    else:
        for i in range(r):
            E += -((2*k)/bernoulli(k))*sigma(k-1,i+1)*q^(i+1)
    return C(E)

# 4. Delta^1/3 = eta^8
def delta(tau, r, prec):
    return eta(tau, r, prec)**8

# 5. gamma function
def gamma(tau, r, prec):
    return eisenstein(4, r, tau, prec) / delta(tau, r, prec)

# sigma(k,n) = \sum_{d|n}d^k
def sigma(k, n):
    sum = n^k
    for i in range(n):
        if i>0:
            if mod(n, i) == 0:
                sum += i^k
    return sum

# Bernoulli's numbers
def bernoulli(k):
    if mod(k, 2) == 1:
        return 0
    else:
        return (-1)^(1+k/2)*2*factorial(k)*zeta(k)/((2*pi)^k)


