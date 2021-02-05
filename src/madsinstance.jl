export MadsInstance, solve!
export UNDEFINED, NO_INIT_CANDIDATES, MIN_MESH_REACHED, MAX_BB_REACHED
export NO_SUCCESS, PARTIAL_SUCCESS, FULL_SUCCESS 

# reason for the algorithm to stop
@enum StopReason UNDEFINED NO_INIT_CANDIDATES MIN_MESH_REACHED MAX_BB_REACHED

# success type at the end of the iteration
@enum SuccessType NO_SUCCESS PARTIAL_SUCCESS FULL_SUCCESS

# stats Mads instance
mutable struct Counters
    neval_bb :: Int # number of calls to the blackbox
    ncache_hits :: Int # number of cache hits

    function Counters()
        return new(0, 0)
    end
end


mutable struct MadsInstance

    # definition parameters of a mads instance
    bbproblem :: BBProblem
    min_tol :: Float64 # minimum tolerance
    gap_selection:: Int # quantifiable gap to select points
    neval_bb_max :: Int # number of maximum blackbox calls

    # storing parameters
    barrier :: Barrier
    cache :: Cache

    # random generator
    rng::AbstractRNG

    # stats
    stats :: Counters

    function MadsInstance(bb :: BBProblem; neval_bb_max :: Int = 100, min_tol :: Float64 = 10^(-9), seed :: Int = 1234)
        if neval_bb_max <= 0
            error("The number of blackbox evaluations cannot be negative !")
        end

        # by convention, a mads instance applies to a problem possessing finite lower and upper bounds
        if any(max.(bb.meta.uvar) == Inf) || any(min.(bb.meta.lvar) == -Inf)
            error("Problem does not possess finite lower bounds or upper bounds !")
        end

        n = bb.meta.ninputs
        m = count(t_o->(t_o == OBJ), bb.meta.typeoutputs)

        return new(bb,
                   min_tol,
                   0,
                   neval_bb_max,
                   Barrier(m),
                   Cache((n, bb.meta.noutputs)),
                   MersenneTwister(seed),
                   Counters())
    end 

end

function reach_nevals_bb_max(mI::MadsInstance)
    return (mI.stats.neval_bb >= mI.neval_bb_max)
end

function eval_candidate!(mI::MadsInstance, candidate::Vector{Float64}, m :: Gmesh)

    if isInCache(mI.cache, candidate)
        mI.stats.ncache_hits += 1
        return ()
    end

    
    if (any(candidate .> mI.bbproblem.meta.uvar) || any(candidate .< mI.bbproblem.meta.lvar))
        println("Warning : candidate out of bounds : ", candidate)
        return ()
    end

    bb_outputs = eval_x(mI.bbproblem, candidate)
    mI.stats.neval_bb += 1

    insertInCache!(mI.cache, EvalPoint(candidate, bb_outputs, m))

    t_outputs = mI.bbproblem.meta.typeoutputs
    nb_obj = count(t_o ->(t_o == OBJ), t_outputs)
    index_obj = findall(t_o -> (t_o == OBJ), t_outputs)
    index_cstrs = findall(t_o -> (t_o == CSTR), t_outputs)

    # by default, if a point is non realisable return empty tuple for the moment
    if any(bb_outputs[index_cstrs] .> 0)
        return ()
        #(mI.stats.neval_bb, OVector(repeat([Inf], nb_obj), 0))
    end

    return (mI.stats.neval_bb, OVector(bb_outputs[index_obj] , 0))

end

function init_phase!(mI::MadsInstance, x0::Vector{Vector{Float64}})
    stop_reason = NO_INIT_CANDIDATES

    # evaluate candidates
    eval_list = Tuple{Int64, OVector}[]
    for elt in x0
        result = eval_candidate!(mI, 
                                 elt,
                                 Gmesh(mI.bbproblem.meta.ninputs, 
                                       0.1 * (mI.bbproblem.meta.uvar - mI.bbproblem.meta.lvar)))
        if !isempty(result)
            push!(eval_list, result)
        end
        if reach_nevals_bb_max(mI)
            stop_reason = MAX_BB_REACHED
            break
        end
    end


    if isempty(eval_list)
        println("No feasible point belongs to the list of candidates")
        return stop_reason
    end

    if stop_reason != MAX_BB_REACHED 
        stop_reason = UNDEFINED
    end

    # add to barrier; points do not have a poll center
    for elt in eval_list
        addFeasible!(mI.barrier, (elt[1], 0, false), elt[2])
    end

    return stop_reason
end

function getpollcenter(mI :: MadsInstance; spread_flag :: Bool = true)::Tuple{Int, Int, Bool}

    if isempty(mI.barrier.bestFeasiblePoints)
        error("Barrier is empty, no current incumbent!")
    end

    # get elements with maximum frame size parameters
    idCandidates = collect(keys(mI.barrier.bestFeasiblePoints))

    # candidates with norm inf
    (max_Δ, id_Δ) = maximum((norm(getFrameSizeParameter(mI.cache.data[i[1]].mesh), Inf), i) for i in idCandidates)
    #  idCandidates = [i for i in idCandidates if norm(getFrameSizeParameter(mI.cache.data[i[1]].mesh), Inf) == max_Δ]

    idCandidates = [i for i in idCandidates if
                    (log10(norm(getMeshSizeParameter(mI.cache.data[id_Δ[1]].mesh), Inf) /
                           norm(getMeshSizeParameter(mI.cache.data[i[1]].mesh), Inf)) <= mI.gap_selection)
                    && !checkMeshForStopping(mI.cache.data[i[1]].mesh)]# <=3

    #println("Candidates with norm max = ", idCandidates)

    # candidates with norm 2
    # (max_Δ, id_Δ) = maximum((norm(getFrameSizeParameter(mI.cache.data[i].mesh)), i) for i in idCandidates)
    # idCandidates = [i for i in idCandidates if norm(getFrameSizeParameter(mI.cache.data[i].mesh)) == max_Δ]

    #println("Candidates with norm 2 = ", idCandidates)

    #println("Maximum frame size parameter = ", string(getFrameSizeParameter(mI.cache.data[id_Δ].mesh)))

    # if all points are under the minimmum mesh size
    if isempty(idCandidates)
        return id_Δ
    end

    if spread_flag == false
        return idCandidates[1]
    end

    # only one point
    if length(idCandidates) == 1
        return idCandidates[1]
    end

    # two points into the barrier
    if length(idCandidates) == 2
        candidate1 = mI.barrier.bestFeasiblePoints[idCandidates[1]]
        candidate2 = mI.barrier.bestFeasiblePoints[idCandidates[2]]
        if norm(candidate1.f, Inf) > norm(candidate2.f, Inf)
            return idCandidates[1]
        else
            return idCandidates[2]
        end
    end

    #=
    # hack: check if one of the points with maximum mesh size is an extreme point
    # get ideal point
    id_poll_extent = Nothing
    ideal_v = Inf * ones(mI.barrier.nb_obj, 1)
    for elt in mI.barrier.bestFeasiblePoints
        ideal_v = min.(elt[2].f, ideal_v)
    end

    # check one point is an extreme point
    extreme_fval = -Inf
    for obj in 1: mI.barrier.nb_obj
        f_array = [(mI.barrier.bestFeasiblePoints[i].f[obj], i) for i in idCandidates]
        f_array = sort(f_array)
    #
        # get minimum point according to one objective
        fmin = f_array[1][1]
        if (fmin <= ideal_v[obj]) && (extreme_fval <= fmin)
            id_poll_extent = f_array[1][2]
            extreme_fval = fmin
        end
    end
    if id_poll_extent != Nothing
        return id_poll_extent
    #  else
    #      println("No extension strategy")
    end
    =#

    # more than two points
    id_poll = Nothing
    gap_max = 0.0
    for obj in 1: mI.barrier.nb_obj
        f_array = [(mI.barrier.bestFeasiblePoints[i].f[obj], i) for i in idCandidates]
        f_array = sort(f_array)

        # get extreme points according to one objective
        fmin = f_array[1][1]
        fmax = f_array[end][1]

        # can happen for exemple when we have several minima or for more than three objectives
        if fmin == fmax
            fmin = 0.0
            fmax = 1.0
        end

        # intermediate points
        for i in 2:length(f_array)-1
            cur_gap = (f_array[i + 1][1] - f_array[i - 1][1]) / (fmax - fmin)
            if cur_gap >= gap_max # need to affect at least one point to the current poll center
                gap_max = cur_gap
                id_poll = f_array[i][2]
            end
        end

        # extreme points
        cur_gap = 2 * (f_array[end][1] - f_array[end - 1][1]) / (fmax - fmin) 
        if cur_gap > gap_max
            gap_max = cur_gap
            id_poll = f_array[end][2]
        end

        cur_gap = 2 * (f_array[2][1] - f_array[1][1]) / (fmax - fmin) 
        if cur_gap > gap_max
            gap_max = cur_gap
            id_poll = f_array[1][2]
        end

    end

    return id_poll

end

function generate_speculative_search_candidates(mI::MadsInstance, x_poll::Vector{Float64}, mesh_poll::Gmesh; last_success_direction=Nothing)

    if last_success_direction == Nothing
        return []
    else
        factor = Inf
        for i in 1:mesh_poll.n
            if last_success_direction[i] != 0
                factor = min(factor, getFrameSizeParameter(mesh_poll)[i] / abs(last_success_direction[i]))
            end
        end
        candidates = x_poll + factor * last_success_direction
        return candidates
    end

end

function generate_poll_candidates(mI::MadsInstance, x_poll::Vector{Float64}, mesh_poll::Gmesh;last_success_direction=Nothing)
    # (poll : random ordering for the moment)

    # implemented: last success direction
    poll_dir = generateDirections(mesh_poll, mI.rng, last_success_direction=last_success_direction)
    # to add if one wants 2n directions
    #poll_dir = generateDirections(mesh_poll, mI.rng)
    
    if last_success_direction != Nothing
    
        function get_angle(dir1, dir2)
            val = dot(dir1, dir2) / (norm(dir1) * norm(dir2))
            if abs(val) > 1
                return acos(1)
            else
                return acos(val)
            end
        end
        poll_dir = sortslices(poll_dir, dims=2, by=elt->get_angle(elt, last_success_direction))
    end

    candidates = poll_dir .+ x_poll
    candidates = [candidates[:, j] for j in 1:size(candidates)[2]] 

    return candidates
end

function preprocess_candidates(mI::MadsInstance, candidates::Vector{Vector{Float64}}, x_poll::Vector{Float64}, mesh_poll::Gmesh)
    # 1- project on the mesh 
    for elt in candidates
        elt[:] = projectOnMesh(mesh_poll, elt, x_poll)
    end

    # 2- snap to bounds if necessary
    for elt in candidates
        elt_tmp = copy(elt)
        δ = getMeshSizeParameter(mesh_poll)

        function snap_value_to_bounds_on_mesh(val, lb, ub, ref_val, δ_val)
            if (lb <= val) && (val <= ub)
                return val
            else
                if val < lb
                    # ref_val is supposed to be >= lb; normally, this rounding is supposed to be in the box constraints
                    return δ_val * ceil((lb - ref_val) / δ_val) + ref_val
                else
                    # ref_value is supposed to be <= ub; normally, this rounding is supposed to be in the box constraints
                    return δ_val * floor((ub - ref_val) / δ_val) + ref_val
                end
            end
        end

        for i in 1:size(elt)[1]
            elt_tmp[i] = snap_value_to_bounds_on_mesh(elt[i], mI.bbproblem.meta.lvar[i], mI.bbproblem.meta.uvar[i], x_poll[i], δ[i])

        end
        elt[:] = elt_tmp
        #elt[:] = max.(mI.bbproblem.meta.lvar, elt)
        #elt[:] = min.(mI.bbproblem.meta.uvar, elt)
    end

    return candidates
end

function get_success_strict_mode!(mI::MadsInstance, id_poll::Tuple{Int, Int, Bool}, infos_candidate::Tuple{Tuple{Int, Int}, OVector})::SuccessType
    x_poll = mI.cache.data[id_poll[1]].inputs
    fx_pool = mI.barrier.bestFeasiblePoints[id_poll]
    if !isDominated(mI.barrier, infos_candidate[2])
        if dominates(mI.barrier, infos_candidate[2]) || extends(mI.barrier, infos_candidate[2])
            enlargeFrameSize!(mI.cache.data[infos_candidate[1][1]].mesh, mI.cache.data[infos_candidate[1][1]].inputs - x_poll) 
        end
    end
    if infos_candidate[2] <= fx_pool
        return FULL_SUCCESS
    else
        return NO_SUCCESS
    end
end

function get_success_dms_mode!(mI::MadsInstance, id_poll::Tuple{Int, Int, Bool}, infos_candidate::Tuple{Tuple{Int, Int}, OVector})::SuccessType
    x_poll = mI.cache.data[id_poll[1]].inputs
    if !isDominated(mI.barrier, infos_candidate[2])
        if dominates(mI.barrier, infos_candidate[2]) || extends(mI.barrier, infos_candidate[2])
            enlargeFrameSize!(mI.cache.data[infos_candidate[1][1]].mesh, mI.cache.data[infos_candidate[1][1]].inputs - x_poll) 
        end
        return FULL_SUCCESS
    end
    return NO_SUCCESS
end

function solve!(mI::MadsInstance, x0::Vector{Vector{Float64}}; opportunistic=true, spread_flag=true, strict_mode=true, display = true)
    stop_reason = init_phase!(mI, x0)
    display && println("bb_calls | iteration | id_poll_center | nb of best feasible elements | success type")
    display && println("------------------------------------------------------------------------------------")
    iteration = 0

    while stop_reason == UNDEFINED
        iteration += 1
        success_flag = NO_SUCCESS

        id_poll = getpollcenter(mI, spread_flag=spread_flag)
        mesh_poll = mI.cache.data[id_poll[1]].mesh
        x_poll = mI.cache.data[id_poll[1]].inputs

        if checkMeshForStopping(mesh_poll)
            stop_reason = MIN_MESH_REACHED
            break
        end

        # poll step
        candidates = Nothing
        # last success direction phase
        if id_poll[2] <= 0
            candidates = generate_poll_candidates(mI, x_poll, mesh_poll)
        else
            last_success_dir = x_poll - mI.cache.data[id_poll[2]].inputs
            if id_poll[3] == false
                candidates = generate_speculative_search_candidates(mI, x_poll, mesh_poll, last_success_direction=last_success_dir)
                candidates = vcat([candidates], generate_poll_candidates(mI, x_poll, mesh_poll, last_success_direction=last_success_dir))
            else
                candidates = generate_poll_candidates(mI, x_poll, mesh_poll, last_success_direction=last_success_dir)
            end
        end
        candidates = preprocess_candidates(mI, candidates, x_poll, mesh_poll)

        # 1-evaluate candidates
        eval_list = Tuple{Tuple{Int, Int, Bool}, OVector}[]
        for x_cand in candidates
            tmp_success_flag = NO_SUCCESS
            result = eval_candidate!(mI, x_cand, mesh_poll)
            if !isempty(result)
                if strict_mode
                    tmp_success_flag = get_success_strict_mode!(mI, id_poll, ((result[1], id_poll[1]), result[2]))
                else 
                    tmp_success_flag = get_success_dms_mode!(mI, id_poll, ((result[1], id_poll[1]), result[2]))
                end
                push!(eval_list, ((result[1], id_poll[1], false), result[2]))
            end
            if tmp_success_flag > success_flag
                success_flag = tmp_success_flag
            end
            if reach_nevals_bb_max(mI)
                stop_reason = MAX_BB_REACHED
                break
            end
            if (success_flag > NO_SUCCESS) 
                if opportunistic
                    break
                end
            end
        end

        # 2-process evaluated candidates 
        for elt in eval_list
            addFeasible!(mI.barrier, elt[1], elt[2]) 
        end

        # 3-update in case of failure
        if success_flag == NO_SUCCESS 
            # if no success, we do not have a success direction
            o_vec = pop!(mI.barrier.bestFeasiblePoints, id_poll)
            addFeasible!(mI.barrier, (id_poll[1], id_poll[2], true), o_vec)
            # update
            refineFrameSize!(mesh_poll)
        else
            display && println("SUCCESS")
        end

        # 3-display informations
        display && @printf("%5d %10d %14d %20d %18s %s\n", mI.stats.neval_bb, iteration, id_poll[1], 
                           length(mI.barrier.bestFeasiblePoints), " ", success_flag)
    end
    display && println("------------------------------------------------------------------------------------")
    println("Summary:")
    println("stop reason= ", stop_reason)
    println("bb_evals= ", mI.stats.neval_bb)
    println("nb_cache_hits= ", mI.stats.ncache_hits)
    println("nb feasible pts founds= ", length(mI.barrier.bestFeasiblePoints))
    return stop_reason
end
