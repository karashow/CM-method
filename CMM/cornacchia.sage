# THE CORNACCHIA ALGORITHM

#INPUT: integers m, d such that 1 <= d < m
#OUTPUT: (x, y) primitive solution of x^2 + d*y^2 = m

def cornacchia(d, m):
    if not mod(-d, m).is_square():
        return "No solutions"
    r_zero = m
    r_one = int(mod(-d, m).sqrt())
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

