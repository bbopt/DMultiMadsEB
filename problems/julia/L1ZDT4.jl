# As described by K. Deb and A. Sinha and S. Kukkonen in "Multi-objective
# test problems, linkages, and evolutionary methodologies", GECCO'06}:·
# Proceedings of the 8th Annual Conference on Genetic and Evolutionary·
# Computation, 1141-1148, 2006.
#
# Example T4, with linkage L1.
#
# This file is part of a collection of problems developed for
# derivative-free multiobjective optimization in
# A. L. Custódio, J. F. A. Madeira, A. I. F. Vaz, and L. N. Vicente,
# Direct Multisearch for Multiobjective Optimization, 2010
# written in julia.
#
# Written by the authors in June 1, 2019.
#
# x var : n = 10
# x[1] <= 1.0, x[2..10] <= 5.0
# x[1] >= 0.0, x[2..10] >= -5.0
#
function L1ZDT4(x)

    #params 
    m = 10;
    A  = [1  0          0           0          0          0           0          0            0           0;
          0   0.884043   -0.272951   -0.993822  0.511197   -0.0997948  -0.659756  0.575496     0.675617    0.180332;
          0   -0.492722  0.0646786   -0.666503  -0.945716  -0.334582   0.611894   0.281032     0.508749    -0.0265389;
          0   0.308861   -0.0437502  -0.374203  0.207359   -0.219433   0.914104   0.184408     0.520599    -0.88565;
          0   -0.708948  -0.37902    0.576578   0.0194674  -0.470262   0.572576   0.351245     -0.480477   0.238261;
          0   -0.827302  0.669248    0.494475   0.691715   -0.198585   0.0492812  0.959669     0.884086    -0.218632;
          0   -0.715997  0.220772    0.692356   0.646453   -0.401724   0.615443   -0.0601957   -0.748176   -0.207987;
          0   0.613732   -0.525712   -0.995728  0.389633   -0.064173   0.662131   -0.707048    -0.340423   0.60624;
          0   -0.160446  -0.394585   -0.167581  0.0679849  0.449799    0.733505   -0.00918638  0.00446808  0.404396;
          0   0.162711   0.294454    -0.563345  -0.114993  0.549589    -0.775141  0.677726     0.610715    0.0850755];

    # functions
    y = A * x;
    f1 = y[1]^2;
    gx = 1 + 10 * (m -1) + sum(y[2:m].^2 - 10 * cos.(4 * pi * y[2:m]));
    h = 1 - sqrt(f1 / gx);

    f2 = gx * h;

    return [f1;f2]

end
