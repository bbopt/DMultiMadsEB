% As described by Huband et al. in "A review of multiobjective test problems
% and a scalable test problem toolkit", IEEE Transactions on Evolutionary·
% Computing 10(5): 477-506, 2006.
%
% Example MOP5, Van Valedhuizen's test suit.
%
% This file is part of a collection of problems developed for
% derivative-free multiobjective optimization in
% A. L. Custódio, J. F. A. Madeira, A. I. F. Vaz, and L. N. Vicente,
% Direct Multisearch for Multiobjective Optimization, 2010
% and implemented in matlab
%
% Written by the authors in June 1, 2019
%
% x var: n = 2,
% x <= 30,
% x >= -30
%
function [F] = MOP5(x);
    f(1) = 0.5 * (x(1)^2 + x(2)^2) + sin(x(1)^2 + x(2)^2);
    f(2) = (3 * x(1) - 2 * x(2) + 4)^2 / 8 + (x(1) - x(2) + 1)^2 / 27 + 15;
    f(3) =  1 / (x(1)^2 + x(2)^2 + 1) -1.1 * exp(-x(1)^2 - x(2)^2);

    F = f';
