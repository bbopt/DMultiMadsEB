# As described by Huband et al. in "A review of multiobjective test problems
# and a scalable test problem toolkit", IEEE Transactions on Evolutionary·
# Computing 10(5): 477-506, 2006.
#
# Example MOP3, Van Valedhuizen's test suit.
#
# This file is part of a collection of problems developed for
# derivative-free multiobjective optimization in
# A. L. Custódio, J. F. A. Madeira, A. I. F. Vaz, and L. N. Vicente,
# Direct Multisearch for Multiobjective Optimization, 2010
# and implemented in julia
#
# Written by the authors in June 1, 2019
#
# x var: n = 2,
# x <= pi,
# x >= -pi
#
function MOP3(x)

    # params
    A1 = 0.5 * sin(1) - 2 * cos(1) + sin(2) - 1.5 * cos(2);
    A2 = 1.5 * sin(1) - cos(1) + 2 * sin(2) - 0.5 * cos(2);
    B1 = 0.5 * sin(x[1]) - 2 * cos(x[1]) + sin(x[2]) - 1.5 * cos(x[2]);
    B2 = 1.5 * sin(x[1]) - cos(x[1]) + 2 * sin(x[2]) - 0.5 * cos(x[2]);

    # functions
    f1 = -1 - (A1 - B1)^2 - (A2 - B2)^2;
    f2 = -(x[1] + 3)^2 - (x[2] + 1)^2;

    # maximization
    return -[f1;f2]

end
