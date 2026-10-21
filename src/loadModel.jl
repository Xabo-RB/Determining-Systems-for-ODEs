"""
    loadModel(path) -> (name, model)

Reads a model file (see Models/) and returns its name and the model in the format used by
src/FiniteDeterminingSystem.jl. The file is read in its own module, so nothing it defines is
left in Main.
"""
function loadModel(path::AbstractString)
    isfile(path) || error("Model file not found: $(path)")
    m = Module(:ModelFile)
    Core.eval(m, :(using Symbolics))   # older model files start with `@variables t`
    Base.include(m, path)
    for v in (:name, :states, :salidas, :parameters, :inputs, :ecuaciones)
        isdefined(m, v) || error("$(path): `$(v)` is not defined")
    end
    model = (estados    = String[string(s) for s in m.states],
             nSalidas   = Int(m.salidas),
             parametros = String[string(s) for s in m.parameters],
             entradas   = String[string(s) for s in m.inputs],
             ecuaciones = String[string(s) for s in m.ecuaciones])
    return string(m.name), model
end
