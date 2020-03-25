# As described by Huband et al. in "A review of multiobjective test problems
# and a scalable test problem toolkit", IEEE Transactions on Evolutionary·
# Computing 10(5): 477-506, 2006.
#
# Example WFG8
#
# This file is part of a collection of problems developed for
# derivative-free multiobjective optimization in
# A. L. Custódio, J. F. A. Madeira, A. I. F. Vaz, and L. N. Vicente,
# Direct Multisearch for Multiobjective Optimization, 2010
# implemented in julia.
#
# Written by the authors in June 1, 2019.
#
# x var : n = 8
# x <= [2*i for i in 1:n]
# x >= 0
#
function WFG8(x)

    # params
    M = 3;
    k = 4;
    l = 4;
    n = k + l;

    S = 2 * [1:M...];

    # neq WFG3
    A = ones(M - 1);

    # problems variables
    zmax = 2 * [1:n...];

    # transform z into [0,1] set
    y = x ./ zmax;

    # first level mapping
    w = ones(n);
    AA = 0.98/49.98;
    BB = 0.02;
    CC = 50;
    r_sum = ones(n);
    for i in k+1:n
        r_sum[i] = sum(w[1:i-1] .* y[1:i-1]) / sum(w[1:i-1]);
    end
    t1 = ones(n);
    t1[1:k] = y[1:k];
    t1[k+1:n] = y[k+1:n].^(BB .+ (CC - BB) * (AA .- (1 .- 2 * r_sum[k+1:n]) .* abs.(floor.(0.5 .- r_sum[k+1:n]) .+ AA)));

    # second level mapping
    t2 = ones(n);
    t2[1:k] = t1[1:k];
    t2[k+1:n] = abs.(t1[k+1:n] .- 0.35) ./ abs.(floor.(0.35 .- t1[k+1:n]) .+ 0.35);

    # third level mapping
    t3 = ones(M);
    for i in 1:M-1
        t3[i] = sum(w[div((i-1)*k, M-1)+1:div(i*k, M-1)] .* t2[div((i-1)*k,M-1)+1:div(i*k,M-1)]) /
        sum(w[div((i-1)*k, M-1)+1:div(i*k, M-1)]);
    end
    t3[M] = sum(w[k+1:n] .* t2[k+1:n]) / sum(w[k+1:n]);

    # Define objective function variables
    xtmp = ones(M);
    xtmp[1:M-1] = max.(t3[M], A) .* (t3[1:M-1] .- 0.5) .+ 0.5;
    xtmp[M] = t3[M] 

    # Define objective function function h
    h = ones(M);
    h[1] = prod(sin.(xtmp[1:M-1] * pi^2));
    for m in 2:M-1
        h[m] = prod(sin.(xtmp[1:M-1] * pi^2)) * cos(xtmp[M-m+1] * pi^2);
    end
    h[M] = cos(xtmp[1] * pi^2);

    # The objective functions
    return xtmp[M] .+ S[1:M] .* h[1:M]

end
