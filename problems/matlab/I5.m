% As described by Huband et al. in "A Scalable Multi-objective Test Problem
% Toolkit", in C. A. Coello Coello et al. (Eds.): EMO 2005, LNCS 3410,·
% pp. 280<96>295, 2005, Springer-Verlag Berlin Heidelberg 2005.
%
% Example I5.
%
% This file is part of a collection of problems developed for
% derivative-free multiobjective optimization in
% A. L. Custódio, J. F. A. Madeira, A. I. F. Vaz, and L. N. Vicente,
% Direct Multisearch for Multiobjective Optimization, 2010
% written in matlab.
%
% Written by the authors in June 1, 2019.
%
% x var : n = 8
% x <= 1.0
% x >= 0.0
%
function [F] = I5(x);
% params
M = 3;
k = 4;
l = 4;
n = k + l;

S = ones(M, 1);

% neq WFG3
A = ones(M - 1, 1);

% problems variables
zmax = ones(n, 1);

% transform z into [0,1] set
y = x ./ zmax;

% first level mapping
w = ones(n, 1) ;
AA = 0.98 / 49.98;
BB = 0.02;
CC = 50;
r_sum = ones(n, 1);
for i=2:n
    r_sum(i) = sum(w(1:i-1) .* y(1:i-1)) / sum(w(1:i-1));
end
t1 = ones(n, 1);
t1(1) = y(1);
t1(2:n) = y(2:n).^(BB + (CC-BB) * (AA - (1 - 2 * r_sum(2:n)).* abs(floor(0.5 - r_sum(2:n))+AA)));

% second level mapping
t2 = ones(n, 1);
t2(1:k) = t1(1:k);
t2(k+1:n) = abs(t1(k+1:n)- 0.35) ./ abs(floor(0.35 - t1(k+1:n)) + 0.35);

% third level mapping
t3 = zeros(M, 1);
for i=1:M-1
    for ii=(i-1) * k/ (M-1)+1:i * k/(M-1)
       t3(i) = t3(i) + t2(ii);
       for jj=0:k/(M-1)-2
           t3(i) = t3(i) + abs(t2(ii) - t2( ((i-1)*k/(M-1)+1) + mod(ii+jj-((i-1)*k/(M-1)+1)+1 , (i*k/(M-1))-((i-1)*k/(M-1)+1)+1)) );
       end
    end
    t3(i) = t3(i) / (((i*k/(M-1))-((i-1)*k/(M-1)+1)+1)/(k/(M-1))*ceil(k/(M-1)/2)*(1+2*k/(M-1)-2*ceil(k/(M-1)/2)));
end
for ii=k+1:n
   t3(M) = t3(M) + t2(ii);
   for jj=0:l-2
    t3(M) = t3(M) + abs(t2(ii) - t2(k+1+ mod(ii+jj-(k+1)+1, n-k)));
   end
   t3(M) = t3(M) / (((n-k)/l)*ceil(l/2)*(1+2*l-2*ceil(l/2)));
end

% Define objective function variables
xtmp = ones(M, 1);
xtmp(1:M-1) = max(t3(M), A) .* (t3(1:M-1) - 0.5) + 0.5;
xtmp(M) = t3(M);

% Define objective function function h
h = ones(M, 1);
h(1) = prod(sin((pi/2) * xtmp(1:M-1)));
for m=2:M-1
    h(m) = prod(sin((pi/2) * xtmp(1:M-m))) * cos(xtmp(M-m + 1) * (pi/2));
end
h(M) = cos(xtmp(1) * (pi/2));

% The objective functions
f(1:M) = xtmp(M) + S(1:M) .* h(1:M);

F = f';
