export OVector, ≦, <=, <, isEqual, isFeasible 

# Outcome Vector
struct OVector

    f :: Vector{Float64} # objective function 
    h :: Float64 # h value

    function OVector(f, h)
        if isempty(f)
            error("objective function cannot be empty")
        end
        if h < 0
            error("h value cannot be negative")
        end
        new(f, h)
    end

end

# print meta information OVector
import Base.print, Base.show, Base.println
function show(io :: IO, v :: OVector)
    s = @sprintf("f = %s\n", string(v.f))
    s *= @sprintf("h = %s\n", string(v.h))
    print(io, s)
end

function print(io :: IO, v :: OVector)
    @printf(io, "f = %s\n", string(v.f))
    @printf(io, "h = %s\n", string(v.h))
end

# check which category does it belong
function isFeasible(v :: OVector)::Bool
    if v.h == 0
        return true
    else 
        return false
    end
end

# relation orders :
# by convention, a feasible vector does not dominates an infeasible vector
# weak dominance
function ≦(v1 :: OVector, v2 :: OVector)::Bool
    if length(v1.f) != length(v2.f)
        return false
    end
    weakly_dom = false;
    if isFeasible(v1) && isFeasible(v2)
        weakly_dom = all(v1.f .<= v2.f)
    elseif !isFeasible(v1) && !isFeasible(v2)
        weakly_dom = all(v1.f .<= v2.f) && (v1.h <= v2.h)
    end
        return weakly_dom
end

import Base.<
# strict dominance
function <(v1 :: OVector, v2 :: OVector)::Bool
    if length(v1.f) != length(v2.f)
        return false
    end
    strict_dom = false;
    if isFeasible(v1) && isFeasible(v2)
        strict_dom = all(v1.f .< v2.f)
    elseif !isFeasible(v1) && !isFeasible(v2)
        strict_dom = all(v1.f .< v2.f) && (v1.h < v2.h)
    end
    return strict_dom
end

# dominance
import Base.<=
function <=(v1 :: OVector, v2 :: OVector)::Bool
    if length(v1.f) != length(v2.f)
        return false
    end
    dominance = false;
    if isFeasible(v1) && isFeasible(v2)
        dominance = all(v1.f .<= v2.f) && any(v1.f .< v2.f)
    elseif !isFeasible(v1) && !isFeasible(v2)
        dominance = (all(v1.f .<= v2.f) && (v1.h < v2.h)) || (all(v1.f .<= v2.f) && any(v1.f .< v2.f) && (v1.h <= v2.h))
    end
    return dominance
end

# equality
function isEqual(v1 :: OVector, v2:: OVector)::Bool
    return (v1.f ≈ v2.f) && (v1.h ≈ v2.h)
end
