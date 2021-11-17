///DomainWarpSingle(seed, amp, freq, DomainWarpType, x, y)
var seed = argument0  //Seed;
var amp = argument1   //DomainWarpAmp * FractalBounding;
var freq = argument2  //Frequency;
var warp = argument3

var xs = argument4;
var ys = argument5;


var returned_array = TransformDomainWarpCoordinate(warp, xs, ys);
  xs = returned_array[0]
  ys = returned_array[1]

var returned_array = DoSingleDomainWarp(seed, amp, freq, warp, xs, ys, argument0, argument1);

return returned_array
