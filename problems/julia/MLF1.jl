# As described by Huband et al. in "A review of multiobjective test problems
# and a scalable test problem toolkit", IEEE Transactions on Evolutionary
# Computing 10(5): 477-506, 2006.
#
# Example MLF1, see the previous cited paper for the original reference.
#
# This file is part of a collection of problems developed for
# derivative-free multiobjective optimization in
# A. L. Custodio, J. F. A. Madeira, A. I. F. Vaz, and L. N. Vicente,
# Direct Multisearch for Multiobjective Optimization, 2010
# and implemented in julia
#
# Written by the authors in June 1, 2019
#
# x var: n = 1,
# x <= 20,
# x >= 0
#
function MLF1(x)

    # functions
    return [(1 + x[1] / 20) * sin(x[1]);
            (1 + x[1] / 20) * cos(x[1])]

end
