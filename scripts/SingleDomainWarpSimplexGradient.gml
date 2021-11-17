///SingleDomainWarpSimplexGradient(seed, warpAmp, frequency, x, y, xr, yr)

var seed = argument0,
    warpAmp = argument1,
    frequency = argument2,
    xx = argument3,
    yy = argument4,
    xr = argument5,
    yr = argument6,
    //outGradOnly = argument7;

var returned_array;

//var SQRT3 = 1.7320508075688772935274463415059;
var G2 = -0.21132486540518711774542560974902;   //(3 - SQRT3) / 6;

var PrimeX = 501125321;
var PrimeY = 1136930381;

xx *= frequency;
yy *= frequency;

/*
 * --- Skew moved to TransformNoiseCoordinate method ---
 * const FNfloat F2 = 0.5f * (SQRT3 - 1);
 * FNfloat s = (x + y) * F2;
 * x += s; y += s;
*/

var i = floor(xx);
var j = floor(yy);
var xi = xx - i;
var yi = yy - j;

var t = (xi + yi) * G2;
var x0 = (xi - t);
var y0 = (yi - t);

i *= PrimeX;
j *= PrimeY;

var vx, vy;
vx = 0;
vy = 0;

var a = 0.5 - x0 * x0 - y0 * y0;
if (a > 0)
{
    aaaa = (a * a) * (a * a);
    
    var hash = gold_noise(seed, i, j)*2-1;
    var xo = hash;
    var yo = hash | 1;
    
    vx += aaaa * xo;
    vy += aaaa * yo;
}

var c = (2 * (1 - 2 * G2) * (1 / G2 - 2)) * t + ((-2 * (1 - 2 * G2) * (1 - 2 * G2)) + a);
if (c > 0)
{
    var x2 = x0 + (2 * G2 - 1);
    var y2 = y0 + (2 * G2 - 1);
    var cccc = (c * c) * (c * c);
    
    var hash = gold_noise(seed, i + PrimeX, j + PrimeY)*2-1;
    var xo = hash;
    var yo = hash | 1;
    
    vx += cccc * xo;
    vy += cccc * yo;
}

if (y0 > x0)
{
    var x1 = x0 + G2;
    var y1 = y0 + (G2 - 1);
    var b = 0.5 - x1 * x1 - y1 * y1;
    if (b > 0)
    {
        var bbbb = (b * b) * (b * b);
        
        var hash = gold_noise(seed, i, j + PrimeY)*2-1;
        var xo = hash;
        var yo = hash | 1;
        
        
        vx += bbbb * xo;
        vy += bbbb * yo;
    }
}
else
{
    var x1 = x0 + (G2 - 1);
    var y1 = y0 + G2;
    var b = 0.5 - x1 * x1 - y1 * y1;
    if (b > 0)
    {
        var bbbb = (b * b) * (b * b);
        
        var hash = gold_noise(seed, i + PrimeX, j)*2-1;
        var xo = hash;
        var yo = hash | 1;
        
        vx += bbbb * xo;
        vy += bbbb * yo;
    }
}

returned_array[0] = xr + (vx * warpAmp);
returned_array[1] = yr + (vy * warpAmp);

return returned_array;

