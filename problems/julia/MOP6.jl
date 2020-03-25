# As described by Huband et al. in "A review of multiobjective test problems
# and a scalable test problem toolkit", IEEE Transactions on Evolutionary·
# Computing 10(5): 477-506, 2006.
#
# Example MOP6, Van Valedhuizen's test suit.
#
# This file is part of a collection of problems developed for
# derivative-free multiobjective optimization in
# A. L. Custódio, J. F. A. Madeira, A. I. F. Vaz, and L. N. Vicente,
# Direct Multisearch for Multiobjective Optimization, 2010
# and implemented in julia
#
# Written by the authors in June 1, 2019
#
# x var: n = 2,
# x <= 6,
# x >= 0
#
function MOP6(x)

    # functions
    return [x[1];
            (1 + 10 * x[2]) * (1 - (x[1] / (1 + 10 * x[2]))^2 - x[1] / (1 + 10 * x[2]) * sin(8 * pi * x[1]))]

end
