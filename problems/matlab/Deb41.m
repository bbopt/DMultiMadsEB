% As described by K. Deb in "Multi-objective Genetic Algorithms: Problem
% Difficulties and Construction of Test Problems", Evolutionary Computation
% 7(3): 205-230, 1999.
%
% Example 4.1 (Multi-modal Multi-objective Problem).
%
% This file is part of a collection of problems developed for
% derivative-free multiobjective optimization in
% A. L. Custódio, J. F. A. Madeira, A. I. F. Vaz, and L. N. Vicente,
% Direct Multisearch for Multiobjective Optimization, 2010
% and written in matlab
%
% Written by the authors in June 1, 2019.
%
% x var : n = 2
% x >= [0.1; 0.0]
% x <= 1.0
%
function [F] = Deb41(x);
    % gx
    gx = 2 - exp(-((x(2) - 0.2) / 0.004)^2) - 0.8 * exp(-((x(2) - 0.6) / 0.4)^2);

    f(1) = x(1);
    f(2) = gx / x(1);

    F = f';
