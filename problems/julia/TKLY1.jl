# As described by Huband et al. in "A review of multiobjective test problems
# and a scalable test problem toolkit", IEEE Transactions on Evolutionary·
# Computing 10(5): 477-506, 2006.
#
# Example TKLY1, see the previous cited paper for the original reference.
#
# This file is part of a collection of problems developed for
# derivative-free multiobjective optimization in
# A. L. Custódio, J. F. A. Madeira, A. I. F. Vaz, and L. N. Vicente,
# Direct Multisearch for Multiobjective Optimization, 2010
# implemented in julia.
#
# Written by the authors in June 1, 2019.
#
# x var : n = 4
# x <= 1
# x >= [0.1; 0; 0; 0]
#
function TKLY1(x)

    # functions
    return [x[1];
            (prod(2.0 .- exp.(-((x[2:4] .- 0.1)/ 0.004).^2) - 0.8 * exp.(-((x[2:4] .- 0.9) / 0.4 ).^2))) / x[1]];

end
