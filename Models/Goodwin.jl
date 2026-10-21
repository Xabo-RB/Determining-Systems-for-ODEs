# ________________________Goodwin__________________________
name = "Goodwin"

states = ["x1", "x2", "x3", "x4"]

salidas = 1

parameters = ["k1", "k2", "k3", "k4", "k5", "k6", "k7"]
#parameters = ["b", "c", "alpha", "beta", "gama", "delta", "sigma"]

inputs = []

ecuaciones = [
    "-k1*x1 + 1 / (k2 + x4)",
    "k3*x1 - k4*x2",
    "k5*x2 - k6*x3",
    "k7*x4* (k5*x2 - k6*x3)/x3",
    "x1"
]
