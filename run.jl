# Determining systems of the symmetries of a model. See README.md.
#
# From a terminal, in this folder:
#     julia run.jl Models/DAISY_EX3.jl SI
#     julia run.jl Models/DAISY_EX3.jl SI infinitesimal
# From VS Code: change the three settings below and run this file.

MODEL = "Models/SEIR.jl"
METHOD = "SI"     # SI, SI_timeT_udep, Obs or General
INFINITESIMAL = false    # false: finite determining system; true: infinitesimal

#__________________________________________________________________________________________

import Pkg
Pkg.activate(@__DIR__; io=devnull)   # packages of this folder (Project.toml)
Pkg.instantiate()                      # installs them the first time

using Symbolics
using SymbolicUtils
include(joinpath(@__DIR__, "src", "FiniteDeterminingSystem.jl"))
include(joinpath(@__DIR__, "src", "loadModel.jl"))

# Command-line arguments replace the settings above
if !isempty(ARGS)
    MODEL = ARGS[1]
    METHOD = length(ARGS) >= 2 ? ARGS[2] : "SI"
    INFINITESIMAL = "infinitesimal" in ARGS[3:end]
end

# Options of finiteDeterminingSystem / infinitesimalDeterminingSystem for each method
METHODS = Dict(
    "SI" => (time_transform=false, input_dependence=false, transform_params=true),
    "SI_timeT_udep" => (time_transform=true, input_dependence=true, transform_params=true),
    "Obs" => (time_transform=false, input_dependence=false, transform_params=false),
    "General" => (time_transform=true, input_dependence=true, transform_params=false,
        transform_inputs=true, include_output=false),
)
haskey(METHODS, METHOD) || error("Unknown method \"$(METHOD)\". Use SI, SI_timeT_udep, Obs or General.")

# A relative model path is looked up in the current folder, and then in this folder
modelPath = isfile(MODEL) ? abspath(MODEL) : joinpath(@__DIR__, MODEL)
name, model = loadModel(modelPath)

resultsDir = joinpath(@__DIR__, "Results")
mkpath(resultsDir)
cd(resultsDir) do
    runDeterminingSystem(model, name, METHOD; infinitesimal=INFINITESIMAL, METHODS[METHOD]...)
end
