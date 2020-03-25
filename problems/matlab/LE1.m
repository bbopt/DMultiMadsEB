% As described by Huband et al. in "A review of multiobjective test problems
% and a scalable test problem toolkit", IEEE Transactions on Evolutionary·
% Computing 10(5): 477-506, 2006.
%
% Example LE1, see the previous cited paper for the original reference.
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
% x <= 10
% x >= -5.0
%
function [F] = LE1(x);
    % functions
    f(1) = (x(1)^2 + x(2)^2)^0.125;
    f(2) = ((x(1) - 0.5)^2 + (x(2) - 0.5)^2)^0.25;

    F = f';
