% As described by Huband et al. in "A review of multiobjective test problems
% and a scalable test problem toolkit", IEEE Transactions on Evolutionary·
% Computing 10(5): 477-506, 2006.
%
% Example WFG6
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
function [F] = WFG6(x);
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
    t2 = zeros(M, 1);
    for i=1:M-1
        for ii=(i-1) * k/ (M-1)+1:i * k/(M-1)
            t2(i) = t2(i) + t1(ii);
            for jj=0:k/(M-1)-2
                t2(i) = t2(i) + abs(t1(ii) - t1( ((i-1)*k/(M-1)+1) + mod(ii+jj-((i-1)*k/(M-1)+1)+1 , (i*k/(M-1))-((i-1)*k/(M-1)+1)+1)) );
            end
        end
        t2(i) = t2(i) / (((i*k/(M-1))-((i-1)*k/(M-1)+1)+1)/(k/(M-1))*ceil(k/(M-1)/2)*(1+2*k/(M-1)-2*ceil(k/(M-1)/2)));
    end
    for ii=k+1:n
        t2(M) = t2(M) + t1(M);
        for jj=0:l-2
            t2(M) = t2(M) + abs(t1(ii) - t1(k+1+ mod(ii+jj-(k+1)+1, n-k)));
        end
        t2(M) = t2(M) / (((n-k)/l)*ceil(l/2)*(1+2*l-2*ceil(l/2)));
    end

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
