# As described by A. Lovison in "A synthetic approach to multiobjective
# optimization", arxiv Item: http://arxiv.org/abs/1002.0093.
#
# Example 3.
#
# In the above paper/papers the variables bounds were not set.
# We considered 0<=x[1]<=6 and -4<=x[2]<=4.
#
# This file is part of a collection of problems developed for
# derivative-free multiobjective optimization in
# A. L. Custódio, J. F. A. Madeira, A. I. F. Vaz, and L. N. Vicente,
# Direct Multisearch for Multiobjective Optimization, 2010
# written in julia.
#
# Written by the authors in June 1, 2019.
#
# x var : n = 2
# x <= [6; 4]
# x >= [0; -4]
#
function lovison3(x)

    # functions
    f1 = -x[1]^2 - x[2]^2;
    f2 = -(x[1] - 6)^2 + (x[2] + 0.3)^2;

    # maximization
    return -[f1;f2]

end
