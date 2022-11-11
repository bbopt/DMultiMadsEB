# As described by Huband et al. in "A review of multiobjective test problems
# and a scalable test problem toolkit", IEEE Transactions on Evolutionary
# Computing 10(5): 477-506, 2006.
#
# Example WFG9
#
# This file is part of a collection of problems developed for
# derivative-free multiobjective optimization in
# A. L. Custodio, J. F. A. Madeira, A. I. F. Vaz, and L. N. Vicente,
# Direct Multisearch for Multiobjective Optimization, 2010
# implemented in julia.
#
# Written by the authors in June 1, 2019.
#
# x var : n = 8
# x <= [2*i for i in 1:n]
# x >= 0
#
function WFG9(x)

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
    for i in 1:n-1
        r_sum[i] = sum(w[i+1:n] .* y[i+1:n]) / sum(w[i+1:n]);
    end
    t1 = ones(n);
    t1[1:n-1] = y[1:n-1].^(BB .+ (CC - BB) * (AA .- (1 .- 2 * r_sum[1:n-1]) .* abs.(floor.(0.5 .- r_sum[1:n-1]) .+ AA)));
    t1[n] = y[n];

    # second level mapping
    t2 = ones(n);
    AAA = 0.35;
    BBB = 0.001;
    CCC = 0.05; 
    AAAA = 30;
    BBBB = 95;
    CCCC = 0.35;
    t2[1:k] = 1 .+ (abs.(t1[1:k] .- AAA) .- BBB) .* ((floor.(t1[1:k] .- AAA .+ BBB) * (1 - CCC + (AAA - BBB) / BBB)) / (AAA - BBB) + (floor.(AAA .+ BBB .- t1[1:k]) * (1 - CCC + (1 - AAA - BBB) / BBB)) / (1 - AAA - BBB) .+ 1/ BBB);
    t2[k+1:n] = (1 .+ cos.((4 * AAAA + 2) * pi * (0.5 .- abs.(t1[k+1:n] .- CCCC) ./ (2 * (floor.(CCCC .- t1[k+1:n]) .+ CCCC)))) + 4 * BBBB * (abs.(t1[k+1:n] .- CCCC) ./ (2 * (floor.(CCCC .- t1[k+1:n]) .+ CCCC))).^2) / (BBBB + 2);

    # third level mapping
    t3 = zeros(M);
    for i in 1:M-1
        for ii in div((i-1) * k, M-1)+1:div(i * k, M-1)
            t3[i] = t3[i] + t2[ii];
            for jj in 0:div(k, M-1)-2
                t3[i] = t3[i] + abs(t2[ii] - t2[ (div((i-1)*k,M-1)+1) + mod(ii+jj-(div((i-1)*k,M-1)+1)+1 , div(i*k,M-1)-(div((i-1)*k,M-1)+1)+1)] ); 
            end
        end
        t3[i] = t3[i] / (((i*k/(M-1))-((i-1)*k/(M-1)+1)+1)/(k/(M-1))*ceil(k/(M-1)/2)*(1+2*k/(M-1)-2*ceil(k/(M-1)/2))); 
    end
    for ii in k+1:n
        t3[M] = t3[M] + t2[ii];
        for jj in 0:l-2
            t3[M] = t3[M] + abs(t2[ii] - t2[k+1+ mod(ii+jj-(k+1)+1, n-k)]);
        end
    end
    t3[M] = t3[M] / (((n-k)/l)*ceil(l/2)*(1+2*l-2*ceil(l/2)));

    # Define objective function variables
    xtmp = ones(M)
    xtmp[1:M-1] = max.(t3[M], A) .* (t3[1:M-1] .- 0.5) .+ 0.5;
    xtmp[M] = t3[M];

    # Define objective function function h
    h = ones(M);
    h[1] = prod(sin.(xtmp[1:M-1] * (pi/2)));
    for m in 2:M-1
        h[m] = prod(sin.(xtmp[1:M-m] * (pi/2))) * cos(xtmp[M-m+1] * (pi/2));
    end
    h[M] = cos(xtmp[1] * (pi/2));

    # The objective functions
    return xtmp[M] .+ S[1:M] .* h[1:M]; 

end
