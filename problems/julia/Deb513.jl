# As described by K. Deb in "Multi-objective Genetic Algorithms: Problem
# Difficulties and Construction of Test Problems", Evolutionary Computation
# 7(3): 205-230, 1999.
#
# Example 5.1.3 (Discontinuous Pareto-optimal Front).
#
# This file is part of a collection of problems developed for
# derivative-free multiobjective optimization in
# A. L. Custodio, J. F. A. Madeira, A. I. F. Vaz, and L. N. Vicente,
# Direct Multisearch for Multiobjective Optimization, 2010
# written in julia.
#
# Written by the authors in June 1, 2019.
# x var : n = 2
# x <= 1.0
# x >= 0.0
#
function Deb513(x)

    # params
    beta = 1
    alpha = 2
    q = 4

    f1 = x[1]

    # gx
    gx = 1 + 10 * x[2]

    # h
    h = 1 - (f1 / gx)^alpha -(f1/gx) * sin(2 * pi * q * f1)

    f2 = gx * h

    # objective function
    return [f1; f2]

end
