# Check that arrays have a prescribed size.
# https://groups.google.com/forum/?fromgroups=#!topic/julia-users/b6RbQ2amKzg
# taken from NLPModels.jl
macro lencheck(l, vars...)
    exprs = Expr[]
    for var in vars
        varname = string(var)
        push!(exprs,
              :(if length($(esc(var))) != $(esc(l))
                    error(string($varname, " must have length ", $(esc(l))))
                end))
    end
    Expr(:block, exprs...)
end

