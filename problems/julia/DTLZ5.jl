# As described by K. Deb, L. Thiele, M. Laumanns and E. Zitzler in "Scalable
# Multi-Objective Optimization Test Problems", Congress on Evolutionary
# Computation (CEC<92>2002): 825-830, 2002.
#
# Example DTLZ5.
#
# This file is part of a collection of problems developed for
# derivative-free multiobjective optimization in
# A. L. Custodio, J. F. A. Madeira, A. I. F. Vaz, and L. N. Vicente,
# Direct Multisearch for Multiobjective Optimization, 2010
# written in julia.
#
# Written by the authors in June 1, 2019.
#
# x var : n = 12
# x <= 1.0
# x >= 0.0
#
function DTLZ5(x)

    # params
    M = 3; # Number of objectives
    n = 12; # Number of variables
    k = n - M + 1;

    # g(x)
    gx = sum(x[M:n].^0.1 );

    # theta
    theta = (pi / 2) * (1 .+ 2 * gx * x) / (2 * (1 + gx));

    # functions
    ff = ones(M);
    ff[1] = (1 + gx ) * (cos(0.5 * pi * x[1])) * prod(cos.(theta[2:M-1]));
    for i in 2:M-1
        ff[i] = (1 + gx) * (cos(0.5 * pi * x[1])) * prod(cos.(theta[2:M-i])) * sin(theta[M-i+1]);
    end
    ff[M] = (1 + gx) * sin(0.5 * pi * x[1]);

    return ff

end
