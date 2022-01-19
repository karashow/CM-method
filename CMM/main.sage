# Generator of CM elliptic curves

import time
load('test.sage')

print("GENERATE CM ELLIPTIC CURVES")

N = int(input("Type the desired number of rational point and press ENTER: "))
init = time.time()
E = myCMM(N)

print("The following:", E)

if E.cardinality() == N:
    print("Has exactly", N, "rational points.")
    final = time.time()
    time = final - init
    print("Time execution:", time, "seconds.")

