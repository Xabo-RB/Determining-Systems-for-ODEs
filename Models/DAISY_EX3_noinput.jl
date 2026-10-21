# ________________________DAISY_EX3 (without input)__________________________
name = "DAISY_EX3_noinput"

states = ["x1", "x2", "x3"]

salidas = 1

parameters = ["p1", "p3", "p4", "p6", "p7"]

inputs = []

ecuaciones = [
    "-p1*x1 + x2",
    "p3*x1 - p4*x2 + x3",
    "p6*x1 - p7*x3",
    "x1"
]
