# As described by K. Deb in "Multi-objective Genetic Algorithms: Problem
# Difficulties and Construction of Test Problems", Evolutionary Computation·
# 7(3): 205-230, 1999.
#
# Example 5.2.1 (Biased Search Space).
#
# This file is part of a collection of problems developed for
# derivative-free multiobjective optimization in
# A. L. Custódio, J. F. A. Madeira, A. I. F. Vaz, and L. N. Vicente,
# Direct Multisearch for Multiobjective Optimization, 2010
# written in julia.
#
# Written by the authors in June 1, 2019.
# x var : n = 2
# x <= 1.0
# x >= 0.0
#
function Deb521b(x)

    # params
    gamma = 1

    f1 = x[1]

    # gx
    gx = 1 + x[2]^gamma

    # h
    h = 1 - (f1 / gx)^2

    f2 = gx * h

    return [f1; f2]

end
