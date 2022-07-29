% As described by Huband et al. in "A review of multiobjective test problems
% and a scalable test problem toolkit", IEEE Transactions on Evolutionary·
% Computing 10(5): 477-506, 2006.
%
% Example WFG4
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
function [F] = WFG4(x);
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
    AA = 30;
    BB = 10;
    CC = 0.35;
    t1 = ones(n,1);
    t1(1:n) = (1 + cos((4 * AA + 2) * pi * (0.5 - abs(y(1:n)-CC) ./ (2 * (floor(CC - y(1:n))+CC)))) ...
        + 4 * BB * (abs(y(1:n)-CC) ./ (2 * (floor(CC - y(1:n)) + CC))).^2)/ (BB+2);

    % second level mapping
    w = ones(n, 1);
    t2 = ones(M, 1);
    for i=1:M-1
        t2(i) = sum(w(((i-1)*k/(M-1)+1):(i*k/(M-1))) .* t1(((i-1)*k/(M-1)+1):(i*k/(M-1)))) / ...
            sum(w(((i-1)*k/(M-1)+1):(i*k/(M-1))));
    end
    t2(M) = sum(w(k+1:n) .* t1(k+1:n)) / sum(w(k+1:n));

    % Define objective function variables
    xtmp = ones(M, 1);
    xtmp(1:M-1) = max(t2(M), A) .* (t2(1:M-1) - 0.5) + 0.5;
    xtmp(M) = t2(M);

    % Define objective function function h
    h = ones(M, 1);
    h(1) = prod(sin(xtmp(1:M-1) * (pi/2)));
    for m=2:M-1
        h(m) = prod(sin(xtmp(1:M-1) * (pi/2))) * cos(xtmp(M-m+1) * (pi/2));
    end
    h(M) = cos(xtmp(1) * (pi/2));

    % The objective functions
    f(1:M) = xtmp(M) + S(1:M) .* h(1:M);

    F = f';
