% As described by Huband et al. in "A review of multiobjective test problems
% and a scalable test problem toolkit", IEEE Transactions on Evolutionary·
% Computing 10(5): 477-506, 2006.
%
% Example FES1, see the previous cited paper for the original reference.
%
% In the above paper the number of variables was left undefined.·
% We selected n=10 as default.
%
% This file is part of a collection of problems developed for
% derivative-free multiobjective optimization in
% A. L. Custódio, J. F. A. Madeira, A. I. F. Vaz, and L. N. Vicente,
% Direct Multisearch for Multiobjective Optimization, 2010
% written in matlab.
%
% Written by the authors in June 1, 2019.
%
% x var : n = 10
% x <= 1.0
% x >= 0.0
%
function [F] = FES1(x);
    % params
    n = 10;

    f(1) = sum(abs(x - exp(((1:n)'/n).^2 /3)).^0.5);
    f(2) = sum((x - 0.5 * cos(10 * pi * (1:n)'/ n) - 0.5).^2);

    F = f';
