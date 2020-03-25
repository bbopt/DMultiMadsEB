% As described by E. Zitzler, K. Deb, and L. Thiele in "Comparison of
% Multiobjective Evolutionary Algorithms: Empirical Results", Evolutionary
% Computation 8(2): 173-195, 2000.
%
% Example T4.
%
% This file is part of a collection of problems developed for
% derivative-free multiobjective optimization in
% A. L. Custódio, J. F. A. Madeira, A. I. F. Vaz, and L. N. Vicente,
% Direct Multisearch for Multiobjective Optimization, 2010
% implemented in matlab.
%
% Written by the authors in June 1, 2019.
%
% x var : n = 10
% x[1] <= 1.0, x[2..n] <= 5.0
% x[1] >= 0.0, x[2..n] >= -5.0
%
function [F] = ZDT4(x);
    % params
    m = 10;

    % functions
    f(1) = x(1);

    gx = 1 + 10 * (m -1) + sum(x(2:m).^2 - 10 * cos(4 * pi * x(2:m)));
    h =  1- sqrt(f(1) / gx);

    f(2) = gx * h;

    F = f';
