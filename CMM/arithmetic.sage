# Cornacchia's Algorithem
# INPUT: integers m, d such that 1 <= d < m
# OUTPUT: (x, y) primitive solution of x^2 + d*y^2 = m

def my_cornacchia(d, m):
    if gcd(d, m) != 1:
        return "ops.."
    if not is_square_mod(-d, m):
        return "No solutions"
    r_zero = m
    r_one = sqrt_mod(-d, m)
    if r_one < 0:
        r_one = -r_one
    while True:
        s = r_one^2
        t = r_one
        if s < m:
            break
        r_one = int(mod(r_zero, r_one))
        r_zero = t
    if sqrt((m - s)/d) == int(sqrt((m-s)/d)):
        return [r_one, sqrt((m - s)/d)]
    else:
        return "No solutions"

#######################################################

# FUNCTIONS

# Legendre Symbol
def legendre(a, p):
    if p == 2:
        return 1
    return pow(a, (p - 1) // 2, p)

# The Tonelli Shanks algorithm
def tonelli(n, p):
    if p == 2:
        return n % 2
    if legendre(n, p) == -1:
        return "Not a square modulo p"
    if legendre(n, p) == 0:
        return 0
    q = p - 1
    s = 0
    while q % 2 == 0:
        q //= 2
        s += 1
    if s == 1:
        return pow(n, (p + 1) // 4, p)
    for z in range(2, p):
        if p - 1 == legendre(z, p):
            break
    c = pow(z, q, p)
    r = pow(n, (q + 1) // 2, p)
    t = pow(n, q, p)
    m = s
    t2 = 0
    while (t - 1) % p != 0:
        t2 = (t * t) % p
        for i in range(1, m):
            if (t2 - 1) % p == 0:
                break
            t2 = (t2 * t2) % p
        b = pow(c, 1 << (m - i - 1), p)
        r = (r * b) % p
        c = (b * b) % p
        t = (t * c) % p
        m = i
    return r

# This function returns a solution of x^2 = N (mod m) for
# relatively prime N, m
def sqrt_mod(N, m):
    if not is_square_mod(N, m):
        return "Not a square modulo m"
    F = factor(m)
    sol = []
    modulous = []
    for i in range(len(F)):
        p = F[i][0]
        e = F[i][1]
        modulous.append(p**e)
        s0 = tonelli(N, p)
        # Hensel lifting
        if e > 1:
            if p == 2:
                sol.append(even_prime_case(N, e))
            else:
                x2 = ZZ(s0)
                prime = p
                for i in range(e):
                    x1 = x2
                    h = (x1**2 - N)/prime
                    k = ZZ(mod(-inverse_mod(2*x1, prime)*h, prime))
                    x2 = x1 + k*prime
                    prime = prime * p
                sol.append(x2)
        else:
            sol.append(ZZ(s0))
    return int(crt(sol, modulous))

def even_prime_case(N, e):
    p = 2
    if e == 2:
        if mod(N, 4) != 1:
            return "No solutions"
        else:
            return 1
    if e >= 3:
        if mod(N, 8) != 1:
            return "No solutions"
        else:
            x2 = 1
            for i in range(3, e):
                x1 = x2
                if mod((x1**2 - N)/(2**i), 2) == 1:
                    x2 = x1 + p**(i-1)
            return x2



# TEST FUNCTIONS

def check_sqrt_mod():
    i = 0
    while i < 50:
        if is_square_mod(N, m):
            return 0
# Check if N is a square modulo m
def is_square_mod(N, m):
    F = factor(m)
    for i in range(len(F)):
        p = F[i][0]
        if legendre(N, p) == -1:
            return false
    return true



