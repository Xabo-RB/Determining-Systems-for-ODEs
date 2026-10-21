# Calculus of the determining systems for ODEs

Builds the determining system (finite or infinitesimal) of the symmetries of an ODE model with outputs. Its needed Julia (1.10 or newer).

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

The determining system gives the conditions for a change of variables

    (t, x, p, u)  ->  (T, X, P, U)        time, states, parameters, inputs

to be a symmetry of the model: it maps solutions of the model to solutions and, when the
output is included, leaves the output unchanged. `METHOD` chooses which variables are
transformed; the others stay as they are (`T = t`, `P = p` or `U = u`).

|                                    | `SI`                       | `SI_timeT_udep`            | `Obs`           | `General`                         |
|------------------------------------|----------------------------|----------------------------|-----------------|-----------------------------------|
| Use it to study                    | SI | SI | Obs.   | Draft Section 2 |
| Time                               | Unch.                  | Trans.                | Unch.       | Trans.                       |
| States                             | Trans.                | Trans.                | Trans.     | Trans.                       |
| Parameters                         | Trans.                | Trans.                | Unch.       | Unch.                         |
| Inputs                             | Unch.                  | Unch.                  | Unch.       | Trans.                       |
| New variables depend on the inputs | no                         | yes                        | no              | yes                               |
| Output must be preserved           | yes                        | yes                        | yes             | no                                |

Abbreviations: **SI** structural identifiability, **Obs.** observability, **Trans.** transformed,
**Unch.** unchanged (`T = t`, `P = p` or `U = u`).

- Each new transformed variable is an unknown function. For example, the new state `X1` is `X1(t, x)` with
  `SI` and `X1(t, x, u)` with `SI_timeT_Udep`. The equations contain its partial derivatives:
  `X1t`, `X1x1`, `X1x2`, ... and also `X1u` if it depends on the inputs. No derivatives with
  respect to the parameters appear, because the parameters do not change with time.
- Transformed parameters must stay constant along the solutions.
- The coefficients file comes from splitting the equations. If an equation is a polynomial in a
  variable that the unknowns do not depend on, it must hold for every value of that variable, so
  each coefficient must vanish separately: `A + B*u = 0` for every `u`, with `A` and `B` free of
  `u`, gives `A = 0` and `B = 0`. This is always done with the input derivatives `u_t`, and also
  with the inputs `u` when the new variables do not depend on them (`SI`, `Obs`).
- In the infinitesimal system, a variable that is not transformed has a zero component in the
  generator: `tau = 0` if `T = t`, `zeta = 0` if `P = p`, `eta = 0` if `U = u`.


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

## Contents

    run.jl                           runs a model
    Models/                          one file per model
    Results/                         result files
    src/FiniteDeterminingSystem.jl   builds, splits and writes the determining systems
    src/loadModel.jl                 reads a model file
    Project.toml, Manifest.toml      packages and their exact versions
