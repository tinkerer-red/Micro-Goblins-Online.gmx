var rx = argument0;
var ry = argument1
/*
Elliptical gradient. Technically it can go beyond your range (0, inf), 
so always clamp the output.
*/
var cx = width / 2; //Center on X axis.
var cy = height / 2; //Center on Y axis.

// Ellipse equation. Calculates value of a point depending on a distance from center. Center is 0.
var dce = ((power(rx-cx,2))/power(cx,2))+((power(ry-cy,2))/power(cy,2));


return clamp(dce, 0, 1);

