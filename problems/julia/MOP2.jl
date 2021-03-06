# As described by Huband et al. in "A review of multiobjective test problems
# and a scalable test problem toolkit", IEEE Transactions on Evolutionary
# Computing 10(5): 477-506, 2006.
#
# Example MOP2, Van Valedhuizen's test suit.
#
# This file is part of a collection of problems developed for
# derivative-free multiobjective optimization in
# A. L. Custodio, J. F. A. Madeira, A. I. F. Vaz, and L. N. Vicente,
# Direct Multisearch for Multiobjective Optimization, 2010
# and implemented in julia
#
# Written by the authors in June 1, 2019
#
# x var: n = 4,
# x <= 4,
# x >= -4
#
function MOP2(x)

    n = 4; # number of variables;

    # functions
    f1 = 1 - exp( -sum((x[1:n] .- 1 / sqrt(n)).^2));
    f2 = 1 - exp( -sum((x[1:n] .+ 1 / sqrt(n)).^2));

    return [f1;f2]

end
