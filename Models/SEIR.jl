# ________________________Example 4.3__________________________
name = "SEIR"

states = ["x1", "x2", "x3", "x4", "x5"]

salidas = 1

parameters = ["beta1","nu1","psi1","gamma1"]

inputs = []

ecuaciones = [
    "-beta1*x1*x3",
    "beta1*x1*x3 - nu1*x2",
    "nu1*x2 - psi1*x3 - (1-psi1)*gamma1*x3",
    "psi1*x3 - gamma1*x4",
    "(1-psi1)*gamma1*x3 + gamma1*x4",
    "x4"
]
