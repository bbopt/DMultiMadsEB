# As described by Huband et al. in "A review of multiobjective test problems
# and a scalable test problem toolkit", IEEE Transactions on Evolutionary
# Computing 10(5): 477-506, 2006.
#
# Example IKK1, see the previous cited paper for the original reference.
#
# This file is part of a collection of problems developed for
# derivative-free multiobjective optimization in
# A. L. Custodio, J. F. A. Madeira, A. I. F. Vaz, and L. N. Vicente,
# Direct Multisearch for Multiobjective Optimization, 2010
# written in julia.
#
# Written by the authors in June 1, 2019.
#
# x var : n = 2
# x <= 50
# x >= -50
#
function IKK1(x)

    f1 = x[1]^2 ;
    f2 = (x[1] - 20)^2;
    f3 = x[2]^2;

    return [f1;f2;f3]

end
