///elliptical_gradient(rx, ry, width, height, percent)

/*
  rx     = x location in grid
  ry     = y location in grid
  width  = grid width
  height = grid height
  perc   = apply percentage, 0.5 will only apply the start of the gradient 50% grom center.
*/

var rx = argument0;
var ry = argument1;
var width = argument2;
var height = argument3;
var perc = argument4;

/*
Elliptical gradient. Technically it can go beyond your range (0, inf), 
so always clamp the output.
*/
var cx = width / 2; //Center on X axis.
var cy = height / 2; //Center on Y axis.

// Ellipse equation. Calculates value of a point depending on a distance from center. Center is 0.
var dce = ((power(rx-cx,2))/power(cx,2))+((power(ry-cy,2))/power(cy,2));
var dce = clamp(dce, perc, 1)

//remove anything under percent

//normalize from start of percent
var _x = (dce-perc)/(1-perc);

return clamp(_x, 0, 1);

