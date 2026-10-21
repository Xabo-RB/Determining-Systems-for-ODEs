# ________________________Example 4.3 New__________________________
name = "SEIRT"

states = ["x1", "x2", "x3", "x4"]

salidas = 1

parameters = ["k1", "k2", "k3"]
#parameters = ["b","alph","lamb"]

inputs = []

ecuaciones = [
    "-k1*x1*x3",
    "k1*x1*x3 - k2*x2",
    "k2*x2 - k3*x3",
    "k3*x3",
    "x3"
]
