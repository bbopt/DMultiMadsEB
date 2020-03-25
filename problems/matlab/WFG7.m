% As described by Huband et al. in "A review of multiobjective test problems
% and a scalable test problem toolkit", IEEE Transactions on Evolutionary·
% Computing 10(5): 477-506, 2006.
%
% Example WFG7
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
function [F] = WFG7(x);
    % params
    M = 3;
    k = 4;
    l = 4;
    n = k + l;

    S = 2 * (1:M)';

    % neq WFG3
    A = ones(M - 1, 1);

    % problems variables
    zmax = 2 * (1:n)';

    % transform z into [0,1] set
    y = x ./ zmax;

    % first level mapping
    w = ones(n, 1);
    AA = 0.98/49.98;
    BB = 0.02;
    CC = 50;
    r_sum = ones(k, 1);
    for i=1:k
        r_sum(i) = sum(w(i+1:n) .* y(i+1:n)) / sum(w(i+1:n));
    end
    t1 = ones(n, 1);
    t1(1:k) = y(1:k).^(BB + (CC - BB) * (AA - (1 - 2 * r_sum(1:k)) .* abs(floor(0.5 - r_sum(1:k))+AA)));
    t1(k+1:n) = y(k+1:n);

    % second level mapping
    t2 = ones(n,1);
    t2(1:k) = t1(1:k);
    t2(k+1:n) = abs(t1(k+1:n) - 0.35) ./ abs(floor(0.35 - t1(k+1:n)) + 0.35);

    % third level mapping
    t3 = ones(M, 1);
    for i=1:M-1
        t3(i) = sum(w(((i-1)*k/(M-1)+1):(i*k/(M-1))) .* t2(((i-1)*k/(M-1)+1):(i*k/(M-1)))) / ...
            sum(w(((i-1)*k/(M-1)+1):(i*k/(M-1))));
    end
    t3(M) = sum(w(k+1:n) .* t2(k+1:n)) / sum(w(k+1:n));

    % Define objective function variables
    xtmp = ones(M, 1);
    xtmp(1:M-1) = max(t3(M), A) .* (t3(1:M-1) - 0.5) + 0.5;
    xtmp(M) = t3(M);

    % Define objective function function h
    h = ones(M, 1);
    h(1) = prod(sin(xtmp(1:M-1) * pi^2));
    for m=2:M-1
        h(m) = prod(sin(xtmp(1:M-1) * pi^2)) * cos(xtmp(M-m+1) * pi^2);
    end
    h(M) = cos(xtmp(1) * pi^2);

    % The objective functions
    f(1:M) = xtmp(M) + S(1:M) .* h(1:M);

    F = f';
