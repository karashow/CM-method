# SOME FUNCTIONS

# Check if D is a discriminant
def is_a_discrtiminant(D):
    if D % 4 == 0 or D % 4 == 1:
        return true
    else:
        return false

# Next discriminant
def next_discriminant(D):
    D = D - 1
    while True:
        if D%4 == 0 or D%4 == 1:
            return D
        else:
            D = D - 1

# Fundamental discriminant: returns the discriminant of the maximal order in
# the imaginary field Q(sqrt(D))
def fundamental_discriminant(D):
    F = factor(D)
    D = -1
    for i in range(len(F)):
        e = F[i][1]
        p = F[i][0]
        if e % 2 != 0:
            D = p * D
    if D % 4 == 2 or D % 4 == 3:
        return 4*D
    else:
        return D
