# ________________________Nick_counterexample_w__________________________
# Nick_counterexample con variable auxiliar w' = u medida como salida
name = "Nick_counterexample_w"

states = ["x", "w"]

salidas = 2

parameters = []

inputs = ["u"]

ecuaciones = [
    "1 + x*u",
    "u",
    "0",
    "w"
]
