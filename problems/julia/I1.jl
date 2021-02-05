# As described by Huband et al. in "A Scalable Multi-objective Test Problem
# Toolkit", in C. A. Coello Coello et al. (Eds.): EMO 2005, LNCS 3410,
# pp. 280<96>295, 2005, Springer-Verlag Berlin Heidelberg 2005.
#
# Example I1.
#
# This file is part of a collection of problems developed for
# derivative-free multiobjective optimization in
# A. L. Custodio, J. F. A. Madeira, A. I. F. Vaz, and L. N. Vicente,
# Direct Multisearch for Multiobjective Optimization, 2010
# written in julia.
#
# Written by the authors in June 1, 2019.
#
# x var : n = 8
# x <= 1.0
# x >= 0.0
#
function I1(x)

    # params
    M = 3;
    k = 4;
    l = 4;
    n = k + l;

    S = ones(M);

    # neq WFG3
    A = ones(M - 1);

    # problems variables
    zmax = ones(n);

    # transform z into [0,1] set
    y = x ./ zmax;

    # first level mapping
    t1 = y;

    # second level mapping
    t2 = ones(n);
    t2[1:k] = t1[1:k];
    t2[k+1:n] = abs.(t1[k+1:n].-0.35) ./ abs.(floor.(0.35 .- t1[k+1:n]) .+ 0.35);

    # third level mapping
    w = ones(n) ;
    t3 = ones(M);
    for i in 1:M-1
        t3[i] = sum(w[div((i - 1) * k, M - 1) + 1: div(i * k, M - 1)] .* t2[div((i - 1) * k, M - 1) + 1: div(i * k, M - 1)]) / sum(w[div((i - 1) * k,  M - 1) + 1: div(i * k, M - 1)]);
    end
    t3[M] = sum(w[k+1:n] .* t2[k+1:n]) / sum(w[k+1:n]) ;

    # Define objective function variables
    xtmp = ones(M);
    xtmp[1:M-1] = max.(t3[M], A) .* (t3[1:M-1] .- 0.5) .+ 0.5;
    xtmp[M] = t3[M];

    # Define objective function function h
    h = ones(M);
    h[1] = prod(sin.(pi^2 * xtmp[1:M-1]));
    for m in 2:M-1
        h[m] = prod(sin.(xtmp[1:M-m] * pi^2)) * cos(xtmp[M-m + 1] * pi^2);
    end
    h[M] = cos(xtmp[1] * pi^2);

    # The objective functions
    f = xtmp[M] .+ S[1:M] .* h[1:M]; 

    return f

end
