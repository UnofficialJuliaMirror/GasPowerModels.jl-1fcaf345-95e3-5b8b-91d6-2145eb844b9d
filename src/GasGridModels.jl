module GasGridModels

using JSON
using MathProgBase
using JuMP
using Compat
using PowerModels
using GasModels
using InfrastructureModels
using Memento

using Compat

if VERSION < v"0.7.0-"
    import Compat: @__MODULE__
end

# Create our module level logger (this will get precompiled)
const LOGGER = getlogger(@__MODULE__)

# Register the module level logger at runtime so that folks can access the logger via `getlogger(GasModels)`
# NOTE: If this line is not included then the precompiled `GasModels.LOGGER` won't be registered at runtime.
__init__() = Memento.register(LOGGER)

"Suppresses information and warning messages output by GasModels, for fine grained control use the Memento package"
function silence()
    Memento.info(LOGGER, "Suppressing information and warning messages for the rest of this session.  Use the Memento package for more fine-grained control of logging.")
    setlevel!(getlogger(InfrastructureModels), "error")
#    setlevel!(getlogger(GasModels), "error")
    setlevel!(getlogger(PowerModels), "error")
end

include("core/base.jl")
include("core/variable.jl")
include("core/constraint.jl")
include("core/constraint_template.jl")
include("core/objective.jl")
include("core/solution.jl")
include("core/data.jl")

include("form/qp.jl")
include("form/nlp.jl")

include("prob/gpf.jl")
include("prob/ne.jl")
include("prob/neopf.jl")

end
