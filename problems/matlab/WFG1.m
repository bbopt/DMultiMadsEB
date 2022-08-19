% As described by Huband et al. in "A review of multiobjective test problems
% and a scalable test problem toolkit", IEEE Transactions on Evolutionary·
% Computing 10(5): 477-506, 2006.
%
% Example WFG1
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
function [F] = WFG1(x);
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
    t1 = ones(n,1);
    t1(1:k) = y(1:k);
    t1(k+1:n) = abs(y(k+1:n) - 0.35) ./ abs(floor(0.35 - y(k+1:n)) + 0.35);

    % second level mapping
    AA = 0.8;
    BB = 0.75;
    CC = 0.85;
    t2 = ones(n ,1);
    t2(1:k) = t1(1:k);
    t2(k+1:n) = AA + min(0, floor(t1(k+1:n) - BB)) .* ( AA * (BB - t1(k+1:n))) ./ ...
        BB - min(0, floor(CC - t1(k+1:n))) * (1 - AA) .* (t1(k+1:n) - CC) / (1-CC);

    % third level mapping
    AAA = 0.02;
    t3 = ones(n, 1);
    % a bit different but can be due to rounding errors close to the limit
    t3(1:n) = abs(t2(1:n)).^AAA;

    % fourth level mapping
    w = 2 * (1:n)';
    t4 = ones(M, 1);
    for i=1:M-1
        t4(i) = sum(w(((i-1)*k/(M-1)+1):(i*k/(M-1))) .* t3(((i-1)*k/(M-1)+1):(i*k/(M-1)))) / ...
            sum(w(((i-1)*k/(M-1)+1):(i*k/(M-1))));
    end
    t4(M) = sum(w(k+1:n) .* t3(k+1:n)) / sum(w(k+1:n));

    % Define objective function variables
    xtmp = ones(M, 1);
    xtmp(1:M-1) = max(t4(M), A) .* (t4(1:M-1) - 0.5) + 0.5;
    xtmp(M) = t4(M);

    % Define objective function function h
    alpha = 1;
    AAAA = 5;
    h = ones(M, 1);
    h(1) = prod((1 - cos((pi/2) * xtmp(1:M-1))));
    for m=2:M-1
        h(m) = prod( (1 - cos((pi/2) * xtmp(1:M-m))) ) * (1 - sin(xtmp(M-m+1) * (pi/2)));
    end
    h(M) = (1 - xtmp(1) - (cos(2 * AAAA * pi * xtmp(1) + (pi/2))) / (2 * AAAA * pi))^alpha;

    % The objective functions
    f(1:M) = xtmp(M) + S(1:M) .* h(1:M);

    F = f';
