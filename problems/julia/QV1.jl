# As described by Huband et al. in "A review of multiobjective test problems
# and a scalable test problem toolkit", IEEE Transactions on Evolutionary·
# Computing 10(5): 477-506, 2006.
#
# Example QV1, see the previous cited paper for the original reference.
#
# In the original reference the number of variables was n=16.·
# We selected n=10 as default.
#
# This file is part of a collection of problems developed for
# derivative-free multiobjective optimization in
# A. L. Custódio, J. F. A. Madeira, A. I. F. Vaz, and L. N. Vicente,
# Direct Multisearch for Multiobjective Optimization, 2010
# implemented in julia.
#
# Written by the authors in June 1, 2019.
#
# x var : n = 10
# x <= 5.12
# x >= -5.12
#
function QV1(x)

    # params
    n = 10;

    #fonctions
    f1 = sum((x[1:n].^2 - 10 * cos.(2 * pi * x[1:n]) .+ 10) / n)^0.25;
    f2 = sum( ((x[1:n] .- 1.5).^2 - 10 * cos.(2 * pi * (x[1:n] .- 1.5)) .+ 10) / n )^0.25;

    return [f1;f2]

end
