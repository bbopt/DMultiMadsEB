# As described by Huband et al. in "A review of multiobjective test problems
# and a scalable test problem toolkit", IEEE Transactions on Evolutionary
# Computing 10(5): 477-506, 2006.
#
# Example SK2, see the previous cited paper for the original reference.
#
# In the above paper/papers the variables bounds were not set.
# We considered -10<=x[i]<=10, i=1,2,3,4.
#
# This file is part of a collection of problems developed for
# derivative-free multiobjective optimization in
# A. L. Custodio, J. F. A. Madeira, A. I. F. Vaz, and L. N. Vicente,
# Direct Multisearch for Multiobjective Optimization, 2010
# implemented in julia.
#
# Written by the authors in June 1, 2019.
#
# x var : n = 4
# x <= 10
# x >= -10
#
function SK2(x)

    # functions
    f1 =  -(x[1] - 2)^2 -(x[2] + 3)^2 -(x[3] - 5)^2 -(x[4] - 4)^2 + 5;
    f2 = sum(sin.(x)) / (1 + sum(x.^2)/ 100);

    # maximization
    return -[f1;f2]

end
