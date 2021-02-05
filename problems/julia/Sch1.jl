# As described by Huband et al. in "A review of multiobjective test problems
# and a scalable test problem toolkit", IEEE Transactions on Evolutionary
# Computing 10(5): 477-506, 2006.
#
# Example Sch1, see the previous cited paper for the original reference.
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
# x <= 5
# x >= 0
#
function Sch1(x)

    # functions
    f1 = 0;
    if x[1] <= 1
        f1 = -x[1];
    elseif x[1] <= 3
        f1 = - 2 + x[1];
    elseif x[1] <= 4
        f1 = 4 - x[1];
    else
        f1 = - 4 + x[1];
    end

    f2 = (x[1] - 5).^2;

    return [f1;f2]

end
