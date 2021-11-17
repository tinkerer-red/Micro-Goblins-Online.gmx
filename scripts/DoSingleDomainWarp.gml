///DoSingleDomainWarp(seed, amp, freq, DomainWarpType, x, y, xr, yr)

var seed = argument0,
    amp  = argument1,
    freq = argument2,
    warp = argument3,
    xx   = argument4,
    yy   = argument5,
    xr   = argument6,
    yr   = argument7;

var returned_array;


switch (warp)
{
    case DomainWarpType.OpenSimplex2:
        returned_array = SingleDomainWarpSimplexGradient(seed, amp * 38.283687591552734375, freq, xx, yy, xr, yr);
        break;
    case DomainWarpType.OpenSimplex2Reduced:
        returned_array = SingleDomainWarpSimplexGradient(seed, amp * 16.0, freq, xx, yy, xr, yr);
        break;
    case DomainWarpType.BasicGrid:
        returned_array = SingleDomainWarpBasicGrid(seed, amp, freq, xx, yy, xr, yr);
        break;
}

return returned_array;
