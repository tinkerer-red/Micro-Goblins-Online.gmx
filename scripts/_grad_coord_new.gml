///_grad_coord_new(xPrimed, yPrimed, xd, yd)

var xx = argument0;
var yy = argument1;

var xPrimed = floor(argument0);
var yPrimed = floor(argument1);
var xg = frac(argument0);
var yg = frac(argument1);


var h = noise_hash(argument0, argument1);

h ^= h >> 15;
h &= 127 << 1;

var xg = _gradients2D(h);
var yg = _gradients2D(h | 1);

return argument2 * xg + argument3 * yg;

