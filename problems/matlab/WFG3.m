% As described by Huband et al. in "A review of multiobjective test problems
% and a scalable test problem toolkit", IEEE Transactions on Evolutionary·
% Computing 10(5): 477-506, 2006.
%
% Example WFG3
%
% This file is part of a collection of problems developed for
% derivative-free multiobjective optimization in
% A. L. Custódio, J. F. A. Madeira, A. I. F. Vaz, and L. N. Vicente,
% Direct Multisearch for Multiobjective Optimization, 2010
% implemented in matlab.
%
% Written by the authors in June 1, 2019.
%
% x var : n = 8
% x <= [2*i for i in 1:n]
% x >= 0
%
function [F] = WFG3(x);
    % params
    M = 3;
    k = 4;
    l = 4;
    n = k + l;

    S = 2 * (1:M)';

    % WFG3
    A = zeros(M - 1, 1);
    A(1) = 1;

    % problems variables
    zmax = 2 * (1:n)';

    % transform z into [0,1] set
    y = x ./ zmax;

    % first level mapping
    t1 = ones(n,1);
    t1(1:k) = y(1:k);
    t1(k+1:n) = abs(y(k+1:n) - 0.35) ./ abs(floor(0.35 - y(k+1:n)) + 0.35);

    % second level mapping
    AA = 2;
    t2 = ones(k + l/2, 1);
    t2(1:k) = t1(1:k);
    for i=k+1:k + l/2
        for ii=(k+2*(i-k)-1):(k+2*(i-k))
            t2(i) = t2(i) + t1(ii);
            for jj=0:AA-2
                t2(i) = t2(i) + abs(t1(ii) - t1( (k+2*(i-k)-1) + mod(ii+jj-(k+2*(i-k)-1)+1, k+2*(i-k)-(k+2*(i-k)-1)+1) ) );
            end
        end
        t2(i) = t2(i) / ((k+2*(i-k)-(k+2*(i-k)-1)+1)/AA*ceil(AA/2)*(1+2*AA-2*ceil(AA/2)));
    end

    % third level mapping
    w = ones(n, 1);
    t3 = ones(M, 1);
    for i=1:M-1
        t3(i) = sum(w(((i-1)*k/(M-1)+1):(i*k/(M-1))) .* t2(((i-1)*k/(M-1)+1):(i*k/(M-1)))) / ...
            sum(w(((i-1)*k/(M-1)+1):(i*k/(M-1))));
    end
    t3(M) = sum(w(k+1:k + l/2 ) .* t2(k+1:k + l/2)) / sum(w(k+1:k+l/2));

    % Define objective function variables
    xtmp = ones(M, 1);
    xtmp(1:M-1) = max(t3(M), A) .* (t3(1:M-1) - 0.5) + 0.5;
    xtmp(M) = t3(M);

    % Define objective function function h
    h = ones(M, 1);
    h(1) = prod(xtmp(1:M-1));
    for m=2:M-1
        h(m) = prod(xtmp(1:M-1)) * (1 - xtmp(M-m+1));
    end
    h(M) = 1 - xtmp(1);

    % The objective functions
    f(1:M) = xtmp(M) + S(1:M) .* h(1:M);

    F = f';
