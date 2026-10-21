# ________________________SlowFast__________________________
name = "SlowFast"

states = ["xA", "xB", "xC"]

salidas = 2

parameters = ["k1", "k2", "eB"]

inputs = ["u1", "u2"]

ecuaciones = [
    "-k1 * xA",
    "k1*xA - k2*xB",
    "k2*xB",
    "xC",
    "u1*xA + eB*xB + u2*xC"
]
