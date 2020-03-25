% As described by K. Deb, L. Thiele, M. Laumanns and E. Zitzler in "Scalable
% Multi-Objective Optimization Test Problems", Congress on Evolutionary·
% Computation (CEC<92>2002): 825-830, 2002.
%
% Example DTLZ6n2.
%
% This file is part of a collection of problems developed for
% derivative-free multiobjective optimization in
% A. L. Custódio, J. F. A. Madeira, A. I. F. Vaz, and L. N. Vicente,
% Direct Multisearch for Multiobjective Optimization, 2010
% written in matlab.
%
% Written by the authors in June 1, 2019.
%
% x var : n = 2
% x <= 1.0
% x >= 0.0
%
function [F] = DTLZ6n2(x);
    % params
    M = 2; % Number of objectives
    n = 2; % Number of variables
    k = n - M + 1;

    % g(x)
    gx = 1 + (9 / k) * sum(x(M:n));

    % functions
    ff = ones(M, 1);
    ff(M) = (1 + gx ) * (M - sum( x(1:M-1)/ (1 + gx) .* (1 + sin(3 * pi * x(1:M-1)))));
    for i = 1:M-1
        ff(i) = x(i);
    end

    F = ff;
