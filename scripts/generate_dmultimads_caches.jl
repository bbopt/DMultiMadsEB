import Distributed

workers = Distributed.addprocs(3)

Distributed.@everywhere begin
    using Pkg
    module_path = "" # enter the module path to DMultiMadsEB
    Pkg.activate(module_path)
    using MATLAB
    import DataStructures.SortedDict
end

Distributed.@everywhere using LightMads

# main function problem
Distributed.@everywhere function run_problem(id_prob)

    problems_path = "" # enter the path to matlab problems
    MATLAB.mxcall(:addpath, 0, problems_path)

    # problems definitions
    dict_problems = SortedDict()

    # BK1
    dict_problems["BK1"] = (2, 2, [-5.0; -5.0], [10.0; 10.0])

    # CL1
    F_p = 10.0
    E_p = 2.0 * 10^5
    L_p = 200.0
    sigma_p = 10
    lb = [ F_p / sigma_p ; sqrt(2) * F_p / sigma_p; sqrt(2) * F_p / sigma_p ; F_p / sigma_p]
    dict_problems["CL1"] = (4, 2, copy(lb), (3 * F_p / sigma_p) * ones(4))

    # Deb41 function
    lb = ([0.1, 0.0])
    dict_problems["Deb41"] = (2, 2, lb, ones(2))

    # Deb512a function
    dict_problems["Deb512a"] = (2, 2, zeros(2), ones(2))

    # Deb512b function
    dict_problems["Deb512b"] = (2, 2, zeros(2), ones(2))

    # Deb512c function
    dict_problems["Deb512c"] = (2, 2, zeros(2), ones(2))

    # Deb513 function:
    dict_problems["Deb513"] = (2, 2, zeros(2), ones(2))

    # Deb521a function
    dict_problems["Deb521a"] = (2, 2, zeros(2), ones(2))

    # Deb521b function
    dict_problems["Deb521b"] = (2, 2, zeros(2), ones(2))

    # Deb53 function
    dict_problems["Deb53"] = (2, 2, zeros(2), ones(2))

    # DG01 function
    dict_problems["DG01"] = (1, 2, -10 * ones(1), 13 * ones(1))

    # DPAM1 function
    dict_problems["DPAM1"] = (10, 2, -0.3 * ones(10), 0.3 * ones(10))

    # DTLZ1 function
    dict_problems["DTLZ1"] = (7, 3, zeros(7), ones(7))

    # DTLZ1n2 function
    dict_problems["DTLZ1n2"] = (2, 2, zeros(2), ones(2))

    # DTLZ2 function
    dict_problems["DTLZ2"] = (12, 3, zeros(12), ones(12))

    # DTLZn2 function
    dict_problems["DTLZ2n2"] = (2, 2, zeros(2), ones(2))

    # DTLZ3 function
    dict_problems["DTLZ3"] = (12, 3, zeros(12), ones(12))

    # DTLZ3n2 function
    dict_problems["DTLZ3n2"] = (2, 2, zeros(2), ones(2))

    # DTLZ4 function
    dict_problems["DTLZ4"] = (12, 3, zeros(12), ones(12))

    # DTLZ4n2 function
    dict_problems["DTLZ4n2"] = (2, 2, zeros(2), ones(2))

    # DTLZ5 function
    dict_problems["DTLZ5"] = (12, 3, zeros(12), ones(12))

    # DTLZ5n2 function
    dict_problems["DTLZ5n2"] = (2, 2, zeros(2), ones(2))

    # DTLZ6 function
    dict_problems["DTLZ6"] = (22, 3, zeros(22), ones(22))

    # DTLZ6n2 function
    dict_problems["DTLZ6n2"] = (2, 2, zeros(2), ones(2))

    # ex005 function
    dict_problems["ex005"] = (2, 2, [-1.0; 1], [2.0; 2.0])

    # Far1 function
    dict_problems["Far1"] = (2, 2, -1 * ones(2), ones(2))

    # FES1 function
    dict_problems["FES1"] = (10, 2, zeros(10), ones(10))

    # FES2 function
    dict_problems["FES2"] = (10, 3, zeros(10), ones(10))

    # FES3 function
    dict_problems["FES3"] = (10, 4, zeros(10), ones(10))

    # Fonseca function
    dict_problems["Fonseca"] = (2, 2, -4 * ones(2), 4 * ones(2))

    # I1 function
    dict_problems["I1"] = (8, 3, zeros(8), ones(8))

    # I2 function
    dict_problems["I2"] = (8, 3, zeros(8), ones(8))

    # I3 function
    dict_problems["I3"] = (8, 3, zeros(8), ones(8))

    # I4 function
    dict_problems["I4"] = (8, 3, zeros(8), ones(8))

    # I5 function
    dict_problems["I5"] = (8, 3, zeros(8), ones(8))

    # IKK1 function
    dict_problems["IKK1"] = (2, 3, -50 * ones(2), 50 * ones(2))

    # IM1 function
    dict_problems["IM1"] = (2, 2, ones(2), [4.0; 2.0])

    # Jin1 function
    dict_problems["Jin1"] = (2, 2, zeros(2), ones(2))

    # Jin2 function
    dict_problems["Jin2"] = (2, 2, zeros(2), ones(2))

    # Jin3 function
    dict_problems["Jin3"] = (2, 2, zeros(2), ones(2))

    # Jin4 function
    dict_problems["Jin4"] = (2, 2, zeros(2), ones(2))

    # Kursawe function
    dict_problems["Kursawe"] = (3, 2, -5 * ones(3), 5 * ones(3))

    # L1ZDT4 function
    dict_problems["L1ZDT4"] = (10, 2, [0.0; -5 * ones(9)], [1.0; 5 * ones(9)])

    # L2ZDT1 function
    dict_problems["L2ZDT1"] = (30, 2, zeros(30), ones(30))

    # L2ZDT2 function
    dict_problems["L2ZDT2"] = (30, 2, zeros(30), ones(30))

    # L2ZDT3 function
    dict_problems["L2ZDT3"] = (30, 2, zeros(30), ones(30))

    # L2ZDT4 function
    dict_problems["L2ZDT4"] = (30, 2, zeros(30), ones(30))

    # L2ZDT6 function
    dict_problems["L2ZDT6"] = (10, 2, zeros(10), ones(10))

    # L3ZDT1 function
    dict_problems["L3ZDT1"] = (30, 2, zeros(30), ones(30))

    # L3ZDT2 function
    dict_problems["L3ZDT2"] = (30, 2, zeros(30), ones(30))

    # L3ZDT3 function
    dict_problems["L3ZDT3"] = (30, 2, zeros(30), ones(30))

    # L3ZDT4 function
    dict_problems["L3ZDT4"] = (30, 2, zeros(30), ones(30))

    # L3ZDT6 function
    dict_problems["L3ZDT6"] = (10, 2, zeros(10), ones(10))

    # LE1 function
    dict_problems["LE1"] = (2, 2, zeros(2), ones(2))

    # lovison1 function
    dict_problems["lovison1"] = (2, 2, zeros(2), 3 * ones(2))

    # lovison2 function
    dict_problems["lovison2"] = (2, 2, -0.5 * ones(2), [0; 0.5])

    # lovison3 function
    dict_problems["lovison3"] = (2, 2, [0.0; -4.0], [6.0; 4.0])

    # lovison4 function
    dict_problems["lovison4"] = (2, 2, [0.0; -1.0], [6.0; 1.0])

    # lovison5 function
    dict_problems["lovison5"] = (3, 3, -1 * ones(3), 4 * ones(3))

    # lovison6 function
    dict_problems["lovison6"] = (3, 3, -1 * ones(3), 4 * ones(3))

    # LRS1 function
    dict_problems["LRS1"] = (2, 2, -50 * ones(2), 50 * ones(2))

    # MHHM1 function
    dict_problems["MHHM1"] = (1, 3, zeros(1), ones(1))

    # MHHM2 function
    dict_problems["MHHM2"] = (2, 3, zeros(2), ones(2))

    # MLF1 function
    dict_problems["MLF1"] = (1, 2, zeros(1), 20 * ones(1))

    # MLF2 function
    dict_problems["MLF2"] = (2, 2, -2 * ones(2), 2 * ones(2))

    # MOP1 function
    dict_problems["MOP1"] = (1, 2, -10^(-5) * ones(1), 10^(5) * ones(1))

    # MOP2 function
    dict_problems["MOP2"] = (4, 2, -4 * ones(4), 4 * ones(4))

    # MOP3 function
    dict_problems["MOP3"] = (2, 2, -pi * ones(2), pi * ones(2))

    # MOP4 function
    dict_problems["MOP4"] = (3, 2, -5 * ones(3), 5 * ones(3))

    # MOP5 function
    dict_problems["MOP5"] = (2, 3, -30 * ones(2), 30 * ones(2))

    # MOP6 function
    dict_problems["MOP6"] = (2, 2, zeros(2), ones(2))

    # MOP7 function
    dict_problems["MOP7"] = (2, 3, -400 * ones(2), 400 * ones(2))

    # OKA1 function
    lb = [6 * sin(pi / 12); -2 * pi * sin(pi / 12)]
    ub = [6 * sin(pi / 12) + 2 * pi * cos(pi / 12); 6 * cos(pi / 12)]
    dict_problems["OKA1"] = (2, 2, copy(lb), copy(ub))

    # OKA2 function
    dict_problems["OKA2"] = (3, 2, [-pi; -5.0; -5.0], [pi; 5.0; 5.0])

    # QV1 function
    dict_problems["QV1"] = (10, 2, -5.12 * ones(10), 5.12 * ones(10))

    # Sch1 function
    dict_problems["Sch1"] = (1, 2, zeros(1), 5 * ones(1))

    # SK1 function
    dict_problems["SK1"] = (1, 2, [-10.0], [10.0])

    # SK2 function
    dict_problems["SK2"] = (4, 2, -10 * ones(4), 10 * ones(4))

    # SP1 function
    dict_problems["SP1"] = (2, 2, -1 * ones(2), 5 * ones(2))

    # SSFYY1 function
    dict_problems["SSFYY1"] = (2, 2, -100 * ones(2), 100 * ones(2))

    # SSFYY2 function
    dict_problems["SSFYY2"] = (1, 2, -100 * ones(1), 100 * ones(1))

    # TKLY1 function
    dict_problems["TKLY1"] = (4, 2, [0.1; 0; 0; 0], ones(4))

    # VFM1 function
    dict_problems["VFM1"] = (2, 3, -2 * ones(2), 2 * ones(2))

    # VU1 function
    dict_problems["VU1"] = (2, 2, -3 * ones(2), 3 * ones(2))

    # VU2 function
    dict_problems["VU2"] = (2, 2, -3 * ones(2), 3 * ones(2))

    # WFG1 function
    dict_problems["WFG1"] = (8, 3, zeros(8), [2.0 * i for i = 1:8])

    # WFG2 function
    dict_problems["WFG2"] = (8, 3, zeros(8), [2.0 * i for i = 1:8])

    # WFG3 function
    dict_problems["WFG3"] = (8, 3, zeros(8), [2.0 * i for i = 1:8])

    # WFG4 function
    dict_problems["WFG4"] = (8, 3, zeros(8), [2.0 * i for i = 1:8])

    # WFG5 function
    dict_problems["WFG5"] = (8, 3, zeros(8), [2.0 * i for i = 1:8])

    # WFG6 function
    dict_problems["WFG6"] = (8, 3, zeros(8), [2.0 * i for i = 1:8])

    # WFG7 function
    dict_problems["WFG7"] = (8, 3, zeros(8), [2.0 * i for i = 1:8])

    # WFG8 function
    dict_problems["WFG8"] = (8, 3, zeros(8), [2.0 * i for i = 1:8])

    # WFG9 function
    dict_problems["WFG9"] = (8, 3, zeros(8), [2.0 * i for i = 1:8])

    # ZDT1 function
    dict_problems["ZDT1"] = (30, 2, zeros(30), ones(30))

    # ZDT2 function
    dict_problems["ZDT2"] = (30, 2, zeros(30), ones(30))

    # ZDT3 function
    dict_problems["ZDT3"] = (30, 2, zeros(30), ones(30))

    # ZDT4 function
    dict_problems["ZDT4"] = (10, 2, [0.0; -5.0 * ones(9)], [1.0; 5.0 * ones(9)])

    # ZDT6 function
    dict_problems["ZDT6"] = (10, 2, zeros(10), ones(10))

    # ZLT1 function
    dict_problems["ZLT1"] = (10, 3, -1000 * ones(10), 1000 * ones(10))

    #println(name_prob)
    name_prob = collect(keys(dict_problems))[id_prob]
    repertory_name = "" # enter the repertory path where you want to store your generated caches
    #for seed in [1234]
    for seed in [1, 4734, 6652, 3507, 1121, 3500, 5816, 2006, 9622, 6117]
        #for success_criteria in [true]
        for success_criteria in [true, false]
            for opportunistic_strategy in [true, false]
                #for spread_selection in [true]
                    for spread_selection in [true, false]
                    # define problem
                    prob = BBProblem(x -> mxcall(Symbol(name_prob), 1, x), 
                                     dict_problems[name_prob][1], 
                                     dict_problems[name_prob][2],
                                     repeat([LightMads.OBJ], dict_problems[name_prob][2]),
                                     lvar=dict_problems[name_prob][3],
                                     uvar=dict_problems[name_prob][4],
                                     name=name_prob)

                    mI = MadsInstance(prob; neval_bb_max = 20000, seed = seed)

                    # define starting points
                    start_points = [];
                    if prob.meta.ninputs == 1
                        start_points = [(prob.meta.lvar[:,] + prob.meta.uvar[:,]) / 2]
                    else 
                        start_points = [prob.meta.lvar[:,] +  (j - 1) * (prob.meta.uvar[:,] - prob.meta.lvar[:,]) / (prob.meta.ninputs - 1)  for j in 1:prob.meta.ninputs]
                    end
                    solve!(mI, start_points, opportunistic=opportunistic_strategy,
                           spread_flag=spread_selection,
                           strict_mode=success_criteria, 
                           display=false)
                    # types of flags
                    success_indic = ""
                    if success_criteria == false
                        success_indic = "No"
                    end
                    opportunistic_indic = ""
                    if opportunistic_strategy == false
                        opportunistic_indic = "No"
                    end
                    spread_indic = ""
                    if spread_selection == false
                        spread_indic = "No"
                    end
                    configuration_solver_string = "_dmMads" * success_indic * "Strict" * opportunistic_indic * "Op" * spread_indic * "Spread_"
                    println(configuration_solver_string)
                    #saveCache(mI.cache, repertory_name * name_prob * "_dmultimadsline_" * string(seed) * ".txt")
                    saveCache(mI.cache, repertory_name * name_prob * configuration_solver_string * string(seed) * ".txt")
                end
            end
        end
    end
    println("Done !")
end


@sync Distributed.@distributed for i in 1:100
    run_problem(i)
end

Distributed.rmprocs(workers)
