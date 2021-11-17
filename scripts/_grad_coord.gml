///_grad_coord(xPrimed, yPrimed, xd, yd)


var h = noise_hash(argument0, argument1);

h ^= h >> 15;
h &= 127 << 1;

var xg = _gradients2D(h);
var yg = _gradients2D(h | 1);

return argument2 * xg + argument3 * yg;

