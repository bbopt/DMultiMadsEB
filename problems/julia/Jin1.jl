# As described by Y. Jin, M. Olhofer and B. Sendhoff. "Dynamic weighted
# aggregation for evolutionary multi-objective optimization: Why does it
# work and how?", in Proceedings of Genetic and Evolutionary Computation·
# Conference, pp.1042-1049, San Francisco, USA, 2001.
#
# Test function 1, F1.
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
# x <= 1
# x >= 0
#
function Jin1(x)

    #params 
    n = 2;

    return [sum(x.^2)/n; 
            sum((x .- 2).^2)/n]

end
