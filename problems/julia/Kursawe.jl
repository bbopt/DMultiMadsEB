# As described by F. Kursawe in "A variant of evolution strategies for
# vector optimization", in H. P. Schwefel and R. Manner, editors, Parallel
# Problem Solving from Nature, 1st Workshop, PPSN I, volume 496 of Lecture
# Notes in Computer Science, pages 193-197, Berlin, Germany, Oct 1991,
# Springer-Verlag.
#
# In the above paper the variables bounds were not set.
# We considered -5.0 <= x[i] <= 5.0, i=1,2,3.
#
# This file is part of a collection of problems developed for
# derivative-free multiobjective optimization in
# A. L. Custodio, J. F. A. Madeira, A. I. F. Vaz, and L. N. Vicente,
# Direct Multisearch for Multiobjective Optimization, 2010
# written in julia.
#
# Written by the authors in June 1, 2019.
#
# x var : n = 3
# x <= 5.0
# x >= -5.0
#
function Kursawe(x)

    #params 
    n = 3;

    # functions
    f1 = sum(-10 * exp.(-0.2 * sqrt.(x[1:n-1].^2 + x[2:n].^2)));
    f2 = sum(abs.(x[1:n]).^0.8 + 5 * sin.(x[1:n]).^3);

    return [f1;f2]

end
