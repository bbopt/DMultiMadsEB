# As described by Huband et al. in "A review of multiobjective test problems
# and a scalable test problem toolkit", IEEE Transactions on Evolutionary�
# Computing 10(5): 477-506, 2006.
#
# Example MOP7, Van Valedhuizen's test suit.
#
# This file is part of a collection of problems developed for
# derivative-free multiobjective optimization in
# A. L. Cust�dio, J. F. A. Madeira, A. I. F. Vaz, and L. N. Vicente,
# Direct Multisearch for Multiobjective Optimization, 2010
# and implemented in julia
#
# Written by the authors in June 1, 2019
#
# x var: n = 2,
# x <= 400,
# x >= -400
#
function MOP7(x)

    # functions
    return [(x[1] - 2)^2 / 2 + (x[2] + 1)^2 / 13 + 3;
            (x[1] + x[2] - 3)^2 / 36 + (-x[1] + x[2] + 2)^2 / 8 - 17;
            (x[1] + 2 * x[2] - 1)^2 / 175 + (-x[1] + 2 * x[2])^2 / 17 - 13]

end
