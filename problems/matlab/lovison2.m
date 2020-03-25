% As described by A. Lovison in "A synthetic approach to multiobjective
% optimization", arxiv Item: http://arxiv.org/abs/1002.0093.
%
% Example 2.
%
% In the above paper/papers the variables bounds were not set.
% We considered -0.5<=x[1]<=0 and -0.5<=x[2]<=0.5.
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
% x <= [0 ; 0.5]
% x >= -0.5
%
function [F] = lovison2(x);
    % functions
    f(1) = -x(2);
    f(2) = (x(2) - x(1)^3) / (x(1) + 1);

    % maximization
    F = -f';
