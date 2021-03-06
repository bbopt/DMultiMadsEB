# As described in
# A simple multi-objective optimization problem (p. 281):
# C.-L. Hwang & A. S. Md. Masud, Multiple Objective
# Decision Making - Methods and Applications, No. 164 in
# Lecture Notes in Economics and Mathematical Systems,
# Springer, 1979.
#
# Example ex005
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
# x <= 2.0
# x >= [-1.0; 1.0]
#
function ex005(x)

    # functions
    return [x[1]^2 - x[2]^2;
            x[1] / x[2]]

end
