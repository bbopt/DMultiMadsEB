# As described by Huband et al. in "A review of multiobjective test problems
# and a scalable test problem toolkit", IEEE Transactions on Evolutionary
# Computing 10(5): 477-506, 2006.
#
# Example MOP4, Van Valedhuizen's test suit.
#
# This file is part of a collection of problems developed for
# derivative-free multiobjective optimization in
# A. L. Custodio, J. F. A. Madeira, A. I. F. Vaz, and L. N. Vicente,
# Direct Multisearch for Multiobjective Optimization, 2010
# and implemented in julia
#
# Written by the authors in June 1, 2019
#
# x var: n = 3,
# x <= 3,
# x >= -3
#
function MOP4(x)

    # functions
    f1 = sum(-10 * exp.(-0.2 * sqrt.(x[1:2].^2 + x[2:3].^2)));
    f2 = sum(abs.(x).^0.8 + 5 * sin.(x.^3));

    return [f1;f2]

end
