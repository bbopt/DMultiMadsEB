# As described by K. Deb in "Multi-objective Genetic Algorithms: Problem
# Difficulties and Construction of Test Problems", Evolutionary Computation
# 7(3): 205-230, 1999.
#
# Example 5.1.2 (Convex Pareto-optimal Front).
#
# This file is part of a collection of problems developed for
# derivative-free multiobjective optimization in
# A. L. Custódio, J. F. A. Madeira, A. I. F. Vaz, and L. N. Vicente,
# Direct Multisearch for Multiobjective Optimization, 2010
# and written in julia
#
# Written by the authors in June 1, 2019.
#
# x var : n = 2
# >= 0.0, <= 1.0
#
function Deb512a(x)

    # params
    beta = 1
    alpha = 0.25

    f1 = 4 * x[1]

    # gx
    gx = 0
    if x[2] <= 0.4
        gx = 4 -3 * exp(-((x[2] - 0.2) / 0.02)^2)
    else
        gx = 4 -2 * exp(-((x[2] - 0.7) / 0.2)^2)
    end

    # h
    h = 0.0;
    if (f1 <= beta * gx)
        h = (1-(f1 / (beta * gx))^alpha)
    end

    # objective functions
    return [f1; gx *h]


end
