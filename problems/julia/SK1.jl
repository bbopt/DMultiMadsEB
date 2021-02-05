# As described by Huband et al. in "A review of multiobjective test problems
# and a scalable test problem toolkit", IEEE Transactions on Evolutionary
# Computing 10(5): 477-506, 2006.
#
# Example SK1, see the previous cited paper for the original reference.
# Function f2 differs in the original and in the cited references. The herein
# codification follows the original reference.
#
# In the above paper/papers the variables bounds were not set.
# We considered -10<=x<=10.
#
# In the original reference the number of variables was n=16.
# We selected n=10 as default.
#
# This file is part of a collection of problems developed for
# derivative-free multiobjective optimization in
# A. L. Custodio, J. F. A. Madeira, A. I. F. Vaz, and L. N. Vicente,
# Direct Multisearch for Multiobjective Optimization, 2010
# implemented in julia.
#
# Written by the authors in June 1, 2019.
#
# x var : n = 1
# x <= 10
# x >= -10
#
function SK1(x)

    # functions
    f1 = -x[1]^4 - 3 * x[1]^3 + 10 * x[1]^2 +10 * x[1] + 10;
    f2 = 0.5 * x[1]^4 + 2 * x[1]^3 + 10 * x[1]^2 - 10 * x[1] + 5;

    return -[f1;f2]

end
