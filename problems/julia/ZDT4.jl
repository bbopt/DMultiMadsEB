# As described by E. Zitzler, K. Deb, and L. Thiele in "Comparison of
# Multiobjective Evolutionary Algorithms: Empirical Results", Evolutionary
# Computation 8(2): 173-195, 2000.
#
# Example T4.
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
# x[1] <= 1.0, x[2..n] <= 5.0
# x[1] >= 0.0, x[2..n] >= -5.0
#
function ZDT4(x)

    #params 
    m = 10;

    # functions
    f1 = x[1];

    gx = 1 + 10 * (m -1) + sum(x[2:m].^2 - 10 * cos.(4 * pi * x[2:m]));
    h =  1- sqrt(f1 / gx);

    f2 = gx * h;

    return [f1;f2]

end
