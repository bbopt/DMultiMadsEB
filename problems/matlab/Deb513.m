% As described by K. Deb in "Multi-objective Genetic Algorithms: Problem
% Difficulties and Construction of Test Problems", Evolutionary Computation·
% 7(3): 205-230, 1999.
%
% Example 5.1.3 (Discontinuous Pareto-optimal Front).
%
% This file is part of a collection of problems developed for
% derivative-free multiobjective optimization in
% A. L. Custódio, J. F. A. Madeira, A. I. F. Vaz, and L. N. Vicente,
% Direct Multisearch for Multiobjective Optimization, 2010
% written in matlab.
%
% Written by the authors in June 1, 2019.
% x var : n = 2
% x <= 1.0
% x >= 0.0
%
function [F] = Deb513(x);
    % parameters
    beta = 1;
    alpha = 4;
    q = 4;

    f(1) = x(1);

    % gx
    gx = 1 + 10 * x(2);

    % h
    h = 1 - (f(1) / gx)^alpha -(f(1)/gx) * sin(2 * pi * q * f(1)); 

    f(2) = gx * h;

    F = f';
