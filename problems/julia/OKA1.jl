# As described by T. Okabe, Y. Jin, M. Olhofer, and B. Sendhoff. "On test
# functions for evolutionary multi-objective optimization.", Parallel
# Problem Solving from Nature, VIII, LNCS 3242, Springer, pp.792-802,
# September 2004.
#
# Test function OKA1.
#
# This file is part of a collection of problems developed for
# derivative-free multiobjective optimization in
# A. L. Custodio, J. F. A. Madeira, A. I. F. Vaz, and L. N. Vicente,
# Direct Multisearch for Multiobjective Optimization, 2010
# implemented in matlab.
#
# Written by the authors in June 1, 2019.
#
# x var : n = 2
# x <= [6*sin(pi/12)+2*pi*cos(pi/12); 6*cos(pi/12)]
# x >= [6*sin(pi/12); -2*pi*sin(pi/12)]
#
function OKA1(x)

    # y variable
    y = zeros(2);
    y[1] = cos(pi/12) * x[1] - sin(pi/12) * x[2];
    y[2] = sin(pi/12) * x[1] + cos(pi/12) * x[2];

    # functions
    f1 = y[1];
    f2 = sqrt(2*pi) - sqrt(abs(y[1])) + 2 * abs(y[2] - 3 * cos(y[1]) - 3)^(1/3);

    return [f1;f2]

end
