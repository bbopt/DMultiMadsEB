# As described by Huband et al. in "A review of multiobjective test problems
# and a scalable test problem toolkit", IEEE Transactions on Evolutionary
# Computing 10(5): 477-506, 2006.
#
# Example ZLT1, see the previous cited paper for the original reference.
#
# In the above paper the number of variables was set equal to 100.
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
# x var : n = 10
# x <= 1000
# x >= -1000
#
function ZLT1(x)

    #params 
    n = 10;
    M = 3;

    # functions
    f = ones(M);
    for m in 1:M
        f[m] = (x[m] - 1)^2 + sum(x[1:end.!=m].^2); 
    end

    return f

end
