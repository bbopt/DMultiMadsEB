export AbstractBBProblem, BBProblem, OutputType, OBJ, CSTR
export eval_x

# specific type for output blackbox
@enum OutputType OBJ CSTR

# base type for BBProblemMeta
abstract type AbstractBBProblemMeta end

struct BBProblemMeta <: AbstractBBProblemMeta

    ninputs :: Int # number of input variables
    lvar :: Vector{Float64} # vector of lower bounds
    uvar :: Vector{Float64} # vector of upper bounds

    noutputs :: Int # number of output variables
    typeoutputs :: Vector{OutputType} # vector of output types

    name :: String # name of the problem


    function BBProblemMeta( ninputs, 
                            noutputs,
                            typeoutputs;
                            lvar = -Inf * ones(ninputs,),
                            uvar = Inf * ones(ninputs,),
                            name = "Generic")
        if (ninputs < 1) || (noutputs < 1)
            error("Nonsensical dimensions")
        end

        @lencheck ninputs uvar lvar 
        @lencheck noutputs typeoutputs
        
        if sum(lvar .< uvar) != ninputs
            error("Wrong box constraints")
        end

        new(ninputs, lvar, uvar, noutputs, typeoutputs, name)
    end
end

# Display BB meta informations
import Base.print, Base.show, Base.println
function show(io :: IO,  bbmeta :: BBProblemMeta)
    s = @sprintf("problem %s\n", bbmeta.name)
    s *= @sprintf("ninputs= %d, noutputs = %d\n", bbmeta.ninputs, bbmeta.noutputs)
    print(io, s)
end

function print(io :: IO, bbmeta :: BBProblemMeta)
    # drawn for NLPModels.jl
    dsp(x) = length(x) == 0 ? print(io, "∅") :
    (length(x) <= 5 ? Base.show_delim_array(io, x, "", "  ", "", false) :
     begin
         Base.show_delim_array(io, x[1:4], "", "  ", "", false)
         print("  ⋯  $(x[end])")
     end)
    @printf(io, "problem %s\n", bbmeta.name)
    @printf(io, "ninputs = %d, noutputs = %d\n", bbmeta.ninputs, bbmeta.noutputs)
    @printf(io, "typeoutputs ="); 
    for i in bbmeta.typeoutputs 
        @printf(io, " %s", i) 
    end 
    @printf(io, "\n");
    @printf(io, "lvar = "); dsp(bbmeta.lvar'); @printf(io, "\n")
    @printf(io, "uvar = "); dsp(bbmeta.uvar'); @printf(io, "\n")
end


# base type for BBProblem
abstract type AbstractBBProblem end

struct BBProblem <: AbstractBBProblem

    meta :: BBProblemMeta

    BB :: Function # Blackbox function 

end

function BBProblem(BB::Function, ninputs::Int, noutputs::Int,
                   typeoutputs::Vector{OutputType};
                   lvar::Vector{Float64}=-Inf * ones(ninputs,),
                   uvar::Vector{Float64}=Inf * ones(ninputs,),
                   name="Generic")

    meta = BBProblemMeta(ninputs, noutputs, 
                         typeoutputs,
                         lvar=lvar, uvar=uvar, 
                         name=name)

    return BBProblem(meta, BB)
end

function eval_x(bbp :: BBProblem, x)
    if length(x) != bbp.meta.ninputs
        error("Blackbox called with wrong number of inputs")
    end
    if (any(x .> bbp.meta.uvar) || any(x .< bbp.meta.lvar))
        error("Point evaluated out of bounds")
    end
    return bbp.BB(x)
end
