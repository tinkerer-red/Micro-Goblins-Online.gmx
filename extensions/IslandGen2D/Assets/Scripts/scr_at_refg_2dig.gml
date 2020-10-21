// Refine grid for ease of autotiling. 
var zz = argument0;
/*
This script refines grid to more solid values*. Much easier to control, detect and change if needed.
*/

if(zz <= 0.15){return 0;} // Water
else if(zz > 0.15 && zz < 0.25){return 10;} // Sand
else if(zz >= 0.25 && zz <= 0.6){return 20;} // Grass
else if(zz > 0.6 && zz <= 0.7){return 30;} // Dirt
else if(zz > 0.7 && zz <= 0.8){return 40;} // Stone
else if(zz > 0.8){return 50;} // Snow


// * - Due to how "return 1" works in compiler, it is not an option, so *10 are used for output.
