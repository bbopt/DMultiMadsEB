# As described by K. Deb, L. Thiele, M. Laumanns and E. Zitzler in "Scalable
# Multi-Objective Optimization Test Problems", Congress on Evolutionary·
# Computation (CEC<92>2002): 825-830, 2002.
#
# Example DTLZ3n2.
#
# This file is part of a collection of problems developed for
# derivative-free multiobjective optimization in
# A. L. Custódio, J. F. A. Madeira, A. I. F. Vaz, and L. N. Vicente,
# Direct Multisearch for Multiobjective Optimization, 2010
# written in julia.
#
# Written by the authors in June 1, 2019.
#
# x var : n = 2
# x <= 1.0
# x >= 0.0
#
function DTLZ3n2(x)

    # params
    M = 2; # Number of objectives
    n = 2; # Number of variables
    k = n - M + 1;

    # g(x)
    gx = 100 * (k + sum((x[M:n] .- 0.5).^2 - cos.(20 * pi * (x[M:n] .- 0.5))));

    # functions
    ff = ones(M);
    ff[1] = (1 + gx) * prod(cos.(0.5 * pi * x[1:M-1]));
    for i in 2:M
        ff[i] = (1 + gx) * prod(cos.(0.5 * pi * x[1:M-i])) * sin.(0.5 * pi * x[M - i + 1]);
    end

    return ff

end
