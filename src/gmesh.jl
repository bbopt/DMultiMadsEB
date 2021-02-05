# implementation of the granular mesh : perform better for the mesh adaptive direct search algorithm
# all variables are continuous in our case

export Gmesh, getMeshSizeParameter, getFrameSizeParameter, enlargeFrameSize!, refineFrameSize!, scaleAndProjectOnMesh,
    generateDirections, projectOnMesh

mutable struct Gmesh

    n :: Int # dimension of the mesh
    minMeshSize ::Float64 # minimum mesh size
    initPollSizeExp :: Vector{Int} # initial poll size exponent

    pollSizeExp :: Vector{Int} # current poll size exponent
    pollSizeMant :: Vector{Int} # current poll size mantisse

    function Gmesh(n :: Int, Δ_init :: Vector{Float64} ;
                   minMeshSize :: Float64 = 10^(-13))
        if n < 1
            error("Non sensical dimensions")
        end

        if sum(Δ_init .<= 0) > 0
            error("Initial frame size parameter cannot be negative")
        end

        @lencheck n Δ_init

        exponents = trunc.(Int, log10.(abs.(Δ_init)))

        function roundPollSizeMant(mant :: Float64)::Int
            # Round input mant to 1, 2 or 5 for pollSizeMant element
            pollSizeMant = 0
            if mant < 1.5
                pollSizeMant = 1
            elseif ( mant >= 1.5) && (mant < 3.5 )
                pollSizeMant = 2
            else
                pollSizeMant = 5
            end

            return pollSizeMant
        end

        mantisses = [roundPollSizeMant(Δ_init[i] * 10.0^(-exponents[i])) for i in 1:length(Δ_init)]

        new(n, minMeshSize, copy(exponents), exponents, mantisses)
    end

end

function getMeshSizeParameter(m :: Gmesh)::Vector{Float64}
    δ = 10.0 .^ (m.pollSizeExp - abs.(m.pollSizeExp - m.initPollSizeExp))
    # if the mesh size parameter is below the minimum mesh size, return the min mesh size
    return max.(m.minMeshSize, δ )
end

function getFrameSizeParameter(m :: Gmesh)::Vector{Float64}
    return m.pollSizeMant .* 10.0 .^ m.pollSizeExp
end

function getRho(m :: Gmesh)::Vector{Float64}
    return m.pollSizeMant .* 10.0 .^ (abs.(m.pollSizeExp - m.initPollSizeExp)) 
end

function enlargeFrameSize!(m :: Gmesh, direction::Vector{Float64}; anisotropyFactor::Float64 = 0.1 )::Bool
    @lencheck m.n direction

    isCHanged = false
    minRho = min(Inf, minimum(getRho(m)))

    for i in 1:m.n
        if (abs(direction[i]) / getMeshSizeParameter(m)[i] / getRho(m)[i] > anisotropyFactor) || ((m.pollSizeExp[i] < m.initPollSizeExp[i]) && (getRho(m)[i] > minRho * minRho ))

            if m.pollSizeMant[i] == 1
                m.pollSizeMant[i] = 2
            elseif m.pollSizeMant[i] == 2
                m.pollSizeMant[i] = 5
            else
                m.pollSizeMant[i] = 1
                m.pollSizeExp[i] += 1
            end
            isChanged = true
        end
    end
    return true
end

function refineFrameSize!(m :: Gmesh)

    # compute new pollSizeMant and pollSizeExp 
    pollSizeMant = copy(m.pollSizeMant)
    pollSizeExp = copy(m.pollSizeExp)

    for i in 1:m.n
        if pollSizeMant[i] == 1
            pollSizeMant[i] = 5
            pollSizeExp[i] -= 1
        elseif pollSizeMant[i] == 2
            pollSizeMant[i] = 1
        else
            pollSizeMant[i] = 2
        end
    end
    
    # safety check
    oldMeshSizeParameter = getMeshSizeParameter(m)
    for i in 1: m.n
        if m.minMeshSize < oldMeshSizeParameter[i]
            m.pollSizeMant[i] = pollSizeMant[i]
            m.pollSizeExp[i] = pollSizeExp[i]
        end
    end

end

function checkMeshForStopping(m :: Gmesh)::Bool
    δ = getMeshSizeParameter(m)
    if any(m.minMeshSize .>= δ)
        return true
    else
        return false
    end
end

# used for projecting directions
function scaleAndProjectOnMesh(m:: Gmesh, elt :: Vector{Float64})::Vector{Float64}
    @lencheck m.n elt
    if norm(elt, Inf) == 0
        error("Cannot handle an infinite norm of zeros")
    end
    δ = getMeshSizeParameter(m)
    rho = getRho(m)
    return round.(rho .* elt / norm(elt, Inf)).*δ
end

# todo : do we have to move it in another file ?
function generateDirections(m:: Gmesh, rng::AbstractRNG; last_success_direction=Nothing)::Array{Float64, 2}
    # direction on the unit sphere
    dir = randn(rng, (m.n))
    dir /= norm(dir)
    
    #dir = zeros(m.n)
    #dir[1] = 1.0

    # householder transformation
    H = I - 2 * dir * transpose(dir)

    # scaling and project directions on the mesh
    for j in 1:size(H)[2]
        H[:, j] = scaleAndProjectOnMesh(m, H[:, j])
    end

    # succ-neg strategy as explained in the paper for orthomads
    if last_success_direction != Nothing
        H_succ_neg = copy(H)
        for j in 1:size(H)[2]
            if dot(last_success_direction, H[:, j]) >= 0
                H_succ_neg[:, j] = H[:, j]
            else
                H_succ_neg[:, j] = -H[:, j]
            end
        end
        return [H_succ_neg -sum(H_succ_neg, dims=2)]

    # 2 n success strategy
    else
        return [H -H]
    end

end

# the projection is made finding the closest element of the mesh centered at pollCenter from elt
function projectOnMesh(m :: Gmesh, elt :: Vector{Float64}, pollCenter :: Vector{Float64})::Vector{Float64}
    @lencheck m.n elt pollCenter
    δ = getMeshSizeParameter(m)
    candidate = zeros(m.n, )
    for i in 1 : m.n
        # stay simple: will maybe changed followingly
        candidate[i] = δ[i] * round((elt[i] - pollCenter[i]) / δ[i]) + pollCenter[i]
    end
    return candidate
end

# print meta information gmesh
import Base.print, Base.show, Base.println
function show(io :: IO, m :: Gmesh)
    s = @sprintf("Dimensions = %d\n", m.n)
    s *= @sprintf("minMeshSize = %d\n", m.minMeshSize)
    s *= @sprintf("initPollSizeExp = %s\n", string(m.initPollSizeExp))
    s *= @sprintf("pollSizeExp = %s\n", string(m.pollSizeExp))
    s *= @sprintf("pollSizeMant = %s\n", string(m.pollSizeMant))
    print(io, s)
end

function print(io :: IO, m :: Gmesh)
    @printf(io, "Dimensions = %d\n", m.n)
    @printf(io, "minMeshSize = %d\n", m.minMeshSize)
    @printf(io, "initPollSizeExp = %s\n", string(m.initPollSizeExp))
    @printf(io, "pollSizeExp = %s\n", string(m.pollSizeExp))
    @printf(io, "pollSizeMant = %s\n", string(m.pollSizeMant))
    @printf(io, "δ^k = %s\n", string(getMeshSizeParameter(m)))
    @printf(io, "Δ^k = %s\n", string(getFrameSizeParameter(m)))
end
