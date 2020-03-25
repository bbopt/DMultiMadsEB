% As described by Huband et al. in "A review of multiobjective test problems
% and a scalable test problem toolkit", IEEE Transactions on Evolutionary·
% Computing 10(5): 477-506, 2006.
%
% Example SSFYY1, see the previous cited paper for the original reference.
%
% This file is part of a collection of problems developed for
% derivative-free multiobjective optimization in
% A. L. Custódio, J. F. A. Madeira, A. I. F. Vaz, and L. N. Vicente,
% Direct Multisearch for Multiobjective Optimization, 2010
% implemented in matlab.
%
% Written by the authors in June 1, 2019.
%
% x var : n = 2
% x <= 100
% x >= -100
%
function [F] = SSFYY1(x);
    % functions
    f(1) = x(1)^2 + x(2)^2;
    f(2) = (x(1) - 1)^2 + (x(2) - 2)^2;

    F = f';
