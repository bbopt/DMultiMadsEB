export Barrier, addFeasible!, isDominated, dominates, extends, saveparetofront

# structure which stores the best candidates found during the iteration
mutable struct Barrier

    bestFeasiblePoints :: SortedDict{Tuple{Int, Int, Bool}, OVector}
    # first index: the index of the objective vector
    # second index: the index of the poll center used to generate it : 
    # if it does not exist, by convention is equal to one
    # last index: a boolean indicated if the previous iteration 
    # which generates this point was a failure
    # it fails
    # if it does not exist, by convention is equal to -1
    nb_obj :: Int # dimensions of vectors
    # todo : add infeasible points, hmax, etc...

    function Barrier(dim)
        if dim <= 0
            error("Non coherent dimensions")
        end

        return new(SortedDict{Tuple{Int, Int, Bool}, OVector}(), dim)
    end

end

# todo: add a printing ?

function checkDimension(b :: Barrier, v ::OVector)
    if b.nb_obj != length(v.f)
        error("Vector and barrier do not have compatible dimensions")
    end
end

# one cannot insert a key with the same id twice
function checkId(b :: Barrier, id :: Tuple{Int, Int, Bool})
    if in(id, keys(b.bestFeasiblePoints))
        error("Another vector possesses the same identifiant")
    end
end

function addFeasible!(b :: Barrier, idCache:: Tuple{Int, Int, Bool}, v::OVector)::Bool
    checkDimension(b, v)
    checkId(b, idCache)
    
    if isempty(b.bestFeasiblePoints)
        b.bestFeasiblePoints[idCache] = v
        return true
    end

    # store dominated points identity
    dom_points = Tuple{Int, Int, Bool}[]
    insert = false
    
    for elt in b.bestFeasiblePoints
        if v <= elt[2]
            insert = true
            push!(dom_points, elt[1])
        end
    end
    
    if !insert
        insert = true
        for elt in b.bestFeasiblePoints
            if elt[2] <= v
                insert = false
                break
            end
        end
    end
    
    # delete dominated points
    for id in dom_points
        delete!(b.bestFeasiblePoints, id)
    end
    
    # add new point
    if insert
        b.bestFeasiblePoints[idCache] = v
    end

    return insert
end

function isDominated(b::Barrier, v::OVector)::Bool
    checkDimension(b, v)
    if isempty(b.bestFeasiblePoints)
        return false
    end
    isDominated = false
    for elt in b.bestFeasiblePoints
        if elt[2] <= v
            return true
        end
    end
    return isDominated
end

function dominates(b::Barrier, v::OVector)::Bool
    checkDimension(b, v)
    if isempty(b.bestFeasiblePoints)
        return false
    end
    dom = false
    for elt in b.bestFeasiblePoints
        if v <= elt[2]
            return true
        end
    end
    return dom
end

function extends(b :: Barrier, v :: OVector)::Bool
    checkDimension(b, v)
    if isempty(b.bestFeasiblePoints)
        return false
    end
    
    # ideal vector of the best points
    ideal_v = Inf * ones(b.nb_obj, 1)
    for elt in b.bestFeasiblePoints
        ideal_v = min.(elt[2].f, ideal_v)
    end
    return any(v.f .< ideal_v)
end

function saveparetofront(b :: Barrier, filename :: String)
    open(filename, "w") do io
    # write values of Pareto front
        for elt in b.bestFeasiblePoints
            writedlm(io, transpose(elt[2].f))
        end
    end

end
