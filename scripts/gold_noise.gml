///gold_noise(seed, x, y)

var PHI = 1.618033988749895

var seed = argument0
var xx = argument1
var yy = argument2

return abs(frac(tan(((xx*yy*PHI) - xx*yy) *seed)*xx*PHI))

