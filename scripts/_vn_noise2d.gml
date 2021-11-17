///_vn_noise2d(seed, x, y)
// returns value between -1 and 1.

var seed = argument0
var ix = floor(argument1);
var iy = floor(argument2);
var fx = frac(argument1);
var fy = frac(argument2);
var ux = fx * fx * (3 - 2 * fx);

return lerp( lerp(gold_noise(seed, ix, iy), gold_noise(seed, ix + 1, iy), ux),
             lerp(gold_noise(seed, ix, iy + 1), gold_noise(seed, ix + 1, iy + 1), ux),
             fy * fy * (3 - 2 * fy)
           );
           

