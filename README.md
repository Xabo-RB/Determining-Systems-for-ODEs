# Symmetries in Julia (v4, without DrWatson)

Builds the determining system (finite or infinitesimal) of the symmetries of an ODE model with
outputs, using the full chain rule (see `../FIX_NOTES.md`). You only need Julia (1.10 or newer).

## How to run it

In a terminal, inside this folder:

    julia run.jl Models/DAISY_EX3.jl SI                  # finite determining system
    julia run.jl Models/DAISY_EX3.jl SI infinitesimal    # infinitesimal determining system

In VS Code: open `run.jl`, change `MODEL`, `METHOD` and `INFINITESIMAL` at the top of the file
and run it ("Julia: Execute active File in REPL").

The first run installs the packages and takes a few minutes; later runs start straight away.

The results are written to `Results/`:

    Results/equations_<name>_<METHOD>.txt       the determining equations, one per line
    Results/coefficients_<name>_<METHOD>.txt    the coefficients that must vanish, one per line

The infinitesimal system adds the prefix `infinitesimal_` to both files.

## Methods

| `METHOD` | What is transformed | Old option (finite / infinitesimal) |
|---|---|---|
| `SI` | states and parameters, `T = t` (ECC setting) | 5 / 4 |
| `SI_timeT_udep` | as `SI`, plus time; the unknowns may depend on the inputs | 6 / 5 |
| `Obs` | states only, parameters fixed, `T = t` | 7 / 3 |
| `General` | time, states and inputs, no output (draft, Section 2) | 8 / 6 |

The old options 1-4 (finite) and 1-2 (infinitesimal) are not here: they use only the diagonal of
the Jacobian (see `../FIX_NOTES.md`). They are still in `../v3/`.

## How to write a model

One file per model in `Models/`. For example, `Models/DAISY_EX3.jl`:

    name = "DAISY_EX3"                    # used in the names of the result files
    states = ["x1", "x2", "x3"]
    salidas = 1                           # number of outputs
    parameters = ["p1", "p3", "p4", "p6", "p7"]
    inputs = ["u"]                        # [] if the model has no inputs
    ecuaciones = [
        "-p1*x1 + x2 + u",                # x1'  (one equation per state, in the same order)
        "p3*x1 - p4*x2 + x3",             # x2'
        "p6*x1 - p7*x3",                  # x3'
        "x1"                              # the outputs go last
    ]

## How to check that it works

    julia scripts/TestFiniteDetSys.jl

The expected output is listed at the top of that file. There is also a cross-check in Python
(it needs `sympy`): `python scripts/reference_detsys.py`, which writes `Results/reference_*`.

## Contents

    run.jl                           runs a model
    Models/                          one file per model
    Results/                         result files
    src/FiniteDeterminingSystem.jl   builds, splits and writes the determining systems
    src/loadModel.jl                 reads a model file
    scripts/TestFiniteDetSys.jl      self-test
    scripts/reference_detsys.py      the same equations in Python (SymPy)
    Project.toml, Manifest.toml      packages and their exact versions
