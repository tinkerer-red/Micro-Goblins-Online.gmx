///SingleDomainWarpBasicGrid(seed, warpAmp, frequency, xx, yy, xr, yr)

var seed = argument0,
    warpAmp = argument1,
    frequency = argument2,
    xx = argument3,
    yy = argument4,
    xr = argument5,
    yr = argument6;

var returned_array;

var xf = xx * frequency;
var yf = yy * frequency;

var x0 = floor(xf);
var y0 = floor(yf);

var PrimeX = 501125321;
var PrimeY = 1136930381;
    
var xs = (xf - x0) * (xf - x0) * (3 - 2 * (xf - x0));
var ys = (yf - y0) * (yf - y0) * (3 - 2 * (yf - y0));

var x0 = x0 * PrimeX;
var y0 = y0 * PrimeY;
var x1 = x0 + PrimeX;
var y1 = y0 + PrimeY;

var hash0 = gold_noise(seed, x0, y0);
var hash1 = gold_noise(seed, x1, y0);

var lx0x = lerp(hash0, hash1, xs);
var ly0x = lerp(hash0 | 1, hash1 | 1, xs);

var hash0 = gold_noise(seed, x0, y1);
var hash1 = gold_noise(seed, x1, y1);

var lx1x = lerp(hash0, hash1, xs);
var ly1x = lerp(hash0 | 1, hash1 | 1, xs);

returned_array[0] = xr + lerp(lx0x, lx1x, ys) * warpAmp;
returned_array[1] = yr + lerp(ly0x, ly1x, ys) * warpAmp;

return returned_array;

