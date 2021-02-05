# As described by Huband et al. in "A review of multiobjective test problems
# and a scalable test problem toolkit", IEEE Transactions on Evolutionary
# Computing 10(5): 477-506, 2006.
#
# Example FES3, see the previous cited paper for the original reference.
#
# In the above paper the number of variables was left undefined.
# We selected n=10 as default.
#
# This file is part of a collection of problems developed for
# derivative-free multiobjective optimization in
# A. L. Custodio, J. F. A. Madeira, A. I. F. Vaz, and L. N. Vicente,
# Direct Multisearch for Multiobjective Optimization, 2010
# written in julia.
#
# Written by the authors in June 1, 2019.
#
# x var : n = 10
# x <= 1.0
# x >= 0.0
#
function FES3(x)

    # params
    n = 10;

    f1 = sum(abs.(x - exp.(((1:n)/n).^2) /3).^0.5);
    f2 = sum(abs.(x - sin.((0:n-1)).^2 .* cos.((0:n-1)).^2).^0.5);
    f3 = sum(abs.(x - 0.25 * cos.((0:n-1)) .* cos.(2 * (0:n-1)) .- 0.5).^0.5);
    f4 = sum((x - 0.5 * sin.(1000 * pi * (1:n)/n) .- 0.5).^2);

    return [f1;f2;f3;f4]

end
