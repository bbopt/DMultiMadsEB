% As described by A. Lovison in "A synthetic approach to multiobjective
% optimization", arxiv Item: http://arxiv.org/abs/1002.0093.
%
% Example 6.
%
% In the above paper/papers the variables bounds were not set.
% We considered -1<=x[i]<=4, i=1,2,3.
%
% This file is part of a collection of problems developed for
% derivative-free multiobjective optimization in
% A. L. Custódio, J. F. A. Madeira, A. I. F. Vaz, and L. N. Vicente,
% Direct Multisearch for Multiobjective Optimization, 2010
% written in matlab.
%
% Written by the authors in June 1, 2019.
%
% x var : n = 3
% x <= 4.0
% x >= -1.0
%
function [F] = lovison6(x);
    % params
    n = 3; % numbers of variables
    m = 4; % numbers of functions used

    % random matrix
    C = [0.218418 -0.620254 0.843784 0.914311;
        -0.788548 0.428212 0.103064 -0.47373; 
        -0.300792 -0.185507 0.330423 0.151614];

    alpha = [0.942022 0.363525 0.00308876;
        0.755598 0.450103 0.170122;
        0.787748 0.837808 0.590166;
        0.203093 0.253639 0.532339];

    % random parameters
    beta = [-0.666503 -0.945716 -0.334582 0.611894];

    % uniform matrix in (-1, 1)
    gamma = [0.281032 0.508749 -0.0265389 -0.920133];

    f_tmp = zeros(m, 1);
    for j=1:m
        for i = 1:n
            f_tmp(j) = f_tmp(j) -alpha(j,i) * (x(i) - C(i,j))^2;
        end
    end

    % functions
    f(1) = f_tmp(1) + beta(1) * exp(f_tmp(4)/ gamma(1));
    f(2) = f_tmp(2) + beta(2) * sin(pi * (x(1) + x(2)) / gamma(2)); 
    f(3) = f_tmp(3) + beta(3) * cos(pi * (x(1) - x(2)) / gamma(3));  

    % maximization
    F = -f';
