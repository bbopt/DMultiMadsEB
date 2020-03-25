# As described by Huband et al. in "A review of multiobjective test problems
# and a scalable test problem toolkit", IEEE Transactions on Evolutionary·
# Computing 10(5): 477-506, 2006.
#
# Example BK1, see the previous cited paper for the original reference.
#
# This file is part of a collection of problems developed for
# derivative-free multiobjective optimization in
# A. L. CustÃ³dio, J. F. A. Madeira, A. I. F. Vaz, and L. N. Vicente,
# Direct Multisearch for Multiobjective Optimization, 2010
# and implemented in julia.
#
# Written by the authors in June 1, 2019
#
# x var: n = 2, >= -5, <= 10
#
function BK1(x)

    return [x[1]^2 + x[2]^2;
            (x[1] - 5)^2 + (x[2] - 5)^2]

end
