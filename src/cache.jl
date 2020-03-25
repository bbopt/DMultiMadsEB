export EvalPoint, Cache, isInCache, insertInCache!, saveCache

# cache structure and eval point for the problem
struct EvalPoint
    
    inputs :: Vector{Float64} # Inputs of the black box
    outputs :: Vector{Float64} # Outputs of the black box

    mesh :: Gmesh

    function EvalPoint(inputs, outputs, m)
        if (length(inputs) < 1) || (length(outputs) < 1)
            error("Non sensical dimensions")
        end

        @lencheck m.n inputs

        new(inputs, outputs, deepcopy(m))
    end
end

# print meta information EvalPoint
import Base.print, Base.show, Base.println
function show(io :: IO, x :: EvalPoint)
    s = @sprintf("Inputs = %s\n", string(x.inputs))
    s *= @sprintf("Outputs = %s\n", string(x.outputs))
    print(io, s)
    show(io, x.mesh)
end

function print(io :: IO, x :: EvalPoint)
    @printf(io, "Inputs = %s\n", string(x.inputs))
    @printf(io, "Outputs = %s\n", string(x.outputs))
    print(io, x.mesh)
end

# this structure keeps all non-redundant points evaluated during the iterations
mutable struct Cache

    dimensions:: Tuple{Int, Int} # precise the dimensions of the inputs and outputs it can take
    data :: Vector{EvalPoint}

    function Cache(dimensions)
        if dimensions[1] <= 0 || dimensions[2] <= 0
            error("Non sensical dimensions")
        end
        new(dimensions, EvalPoint[])
    end

end

# return true if the point is in cache, false otherwise
function isInCache(c :: Cache, x :: Vector{Float64} )::Bool
    if length(x) != c.dimensions[1]
        return false
    end

    inCache = false
    for elt in c.data
        if maximum(abs.(elt.inputs - x)) <= 10^(-9)
            inCache = true
            break
        end
    end
    return inCache
end

# return true if the insertion works, false otherwise
function insertInCache!(c :: Cache, x :: EvalPoint )::Bool
    isOk = isInCache(c, x.inputs)
    if isOk == false
        if (length(x.inputs) == c.dimensions[1]) && (length(x.outputs) == c.dimensions[2])
            push!(c.data, x)
            return true
        end
    end
    return false
end

function saveCache(c :: Cache, filename :: String)
    open(filename, "w") do io
        # write dimensions of the cache
        writedlm(io, transpose(collect(c.dimensions)))
        # write inputs and outputs in the file
        for elt in c.data
            writedlm(io, transpose([elt.inputs; elt.outputs]))
        end
    end
end

# print meta information on cache
function print(io :: IO , c :: Cache)
    @printf(io, "Dimensions elements = %s\n", string(c.dimensions))
    @printf(io, "Number elements = %d\n\n", length(c.data))
    for elt in c.data
        println(io, elt)
    end
end

