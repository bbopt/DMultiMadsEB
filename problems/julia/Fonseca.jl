# As described by C.M. Fonseca and P.J. Fleming in "Multiobjective
# Optimization and Multiple Constraint Handling with Evolutionary
# Algorithms<96>Part I: A Unified Formulation", in IEEE Transactions
# on Systems, Man, and Cybernetics<97>Part A: Systems and Humans,
# vol. 28, no. 1, January 1998.
#
# Example Fonseca
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
# x <= 4.0
# x >= -4.0
#
function Fonseca(x)

    # objective functions
    f1 = 1-exp(-(x[1]-1)^2-(x[2]+1)^2);
    f2 = 1-exp(-(x[1]+1)^2-(x[2]-1)^2);

    return [f1;f2]

end
