# As described by E. Zitzler, K. Deb, and L. Thiele in "Comparison of
# Multiobjective Evolutionary Algorithms: Empirical Results", Evolutionary
# Computation 8(2): 173-195, 2000.
#
# Example T6.
#
# This file is part of a collection of problems developed for
# derivative-free multiobjective optimization in
# A. L. Custodio, J. F. A. Madeira, A. I. F. Vaz, and L. N. Vicente,
# Direct Multisearch for Multiobjective Optimization, 2010
# implemented in julia.
#
# Written by the authors in June 1, 2019.
#
# x var : n = 10
# x <= 1.0
# x >= 0.0
#
function ZDT6(x)

    #params 
    m = 10;

    # functions
    f1 = 1 - exp(-4 * x[1]) * sin(6 * pi * x[1])^6;

    gx = 1 + 9 * (sum(x[2:m]) / (m - 1))^0.25;
    h =  1- (f1 / gx)^2;

    f2 = gx * h;

    return [f1;f2]

end
