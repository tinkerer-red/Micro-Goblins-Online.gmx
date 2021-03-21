///elliptical_gradient_non_centered(rx, ry, cx, cy, width, height, percent)

/*
  rx     = x location in grid
  ry     = y location in grid
  cx     = x location on grid for the center of the gradient
  cy     = y location on grid for the center of the gradient
  width  = grid width
  height = grid height
  perc   = apply percentage, 0.5 will only apply the start of the gradient 50% from center.
*/
//show_debug_message("elliptical_gradient_non_centered")
var rx = argument0;
var ry = argument1;
var cx = argument2;
var cy = argument3;
var width = argument4;
var height = argument5;
var perc = argument6;

/*
Elliptical gradient. Technically it can go beyond your range (0, inf), 
so always clamp the output.
*/

// Ellipse equation. Calculates value of a point depending on a distance from center. Center is 0.
var dce = ((power(rx-cx,2))/power(cx,2))+((power(ry-cy,2))/power(cy,2));
var dce = clamp(dce, perc, 1)

//remove anything under percent

//normalize from start of percent
var _x = (dce-perc)/(1-perc);

return clamp(_x, 0, 1);

