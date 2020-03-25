% As described by A. Lovison in "A synthetic approach to multiobjective
% optimization", arxiv Item: http://arxiv.org/abs/1002.0093.
%
% Example 1.
%
% In the above paper/papers the variables bounds were not set.
% We considered 0<=x[i]<=3, i=1,2.
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
% x <= 3.0
% x >= 0.0
%
function [F] = lovison1(x);
    % functions

    f(1) = -1.05 * x(1)^2 - 0.98 * x(2)^2;
    f(2) = -0.99 * (x(1) - 3)^2 - 1.03 * (x(2) - 2.5)^2;

    % maximization
    F = -f';
