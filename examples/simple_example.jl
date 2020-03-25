using DMultiMadsEB

# define function
function DTLZ3_fct(x)
    # params
    M = 3 # number of objectives
    n = 12 # number of variables
    k = n - M + 1

    gx = 100 * (k + sum((x[M:n] .- 0.5).^2 - cos.(20 * pi * (x[M:n] .- 0.5))));

    # functions
    ff = ones(M);
    ff[1] = (1 + gx) * prod(cos.(0.5 * pi * x[1:M-1]));
    for i = 2:M
        ff[i] = (1 + gx) * prod(cos.(0.5 * pi * x[1:M-i])) * sin(0.5 * pi * x[M - i + 1]);
    end

    return ff

end

# define BB problem
DTLZ3 = BBProblem(x -> DTLZ3_fct(x),
                  12, 3, # number of variable inputs, number of outputs
                  [OBJ; OBJ; OBJ], # type of outputs
                  lvar=zeros(12), # lower bounds
                  uvar=ones(12), # upper bounds
                  name="DTLZ3")

# create mads instance
madsI = MadsInstance(DTLZ3; neval_bb_max=1000)

# choose start points
start_points = [DTLZ3.meta.lvar[:,] +  (j - 1) * (DTLZ3.meta.uvar[:,] - DTLZ3.meta.lvar[:,]) / (DTLZ3.meta.ninputs - 1)  for j in 1:DTLZ3.meta.ninputs]

# solve problem; other options can be added
stop = solve!(madsI, start_points, opportunistic=false)

# collect interesting informations
print(madsI.cache.data)
print(madsI.barrier.bestFeasiblePoints)
