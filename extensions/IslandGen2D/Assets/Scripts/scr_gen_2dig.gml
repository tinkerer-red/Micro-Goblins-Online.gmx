var oc = argument0;
var pers = argument1;
var wm = argument2;
var lac = argument3;
var isIsland = argument4;
var refined = argument5;

for(var i = 0; i < width; i++){
    for(var j = 0; j < height; j++){
    
            if(argument4 == 1){ // Generate island by subtracting elliptical gradient from main noise.
            
                if(argument5 == 0){ // If autotiling isn't needed, continue normally.
                
                    var zz = clamp((scr_value_2dig(i, j, oc, pers, wm, lac) - scr_crad_2dig(i, j)),0,1);
                    grid[# i,j] = zz;
                    /*
                    Due to nature of the elliptical gradient equation, it could be something like: 
                    0.5 - 0.7 = -0.2, 
                    so clamp the output within your range.
                    */
                    
                } else { // Else send grid values to "refining" script.
                
                    var zz = clamp((scr_value_2dig(i, j, oc, pers, wm, lac) - scr_crad_2dig(i, j)),0,1);
                    grid[# i,j] = scr_at_refg_2dig(zz);
                
                }
                
            } else { // Generate full room landmass.
            
                if(argument5 == 0){ // If autotiling isn't needed, continue normally.
                
                    var zz = scr_value_2dig(i, j, oc, pers, wm, lac);
                    grid[# i,j] = zz;            
                    
               } else { // Else send grid values to "refining" script.

                    var zz = scr_value_2dig(i, j, oc, pers, wm, lac);
                    grid[# i,j] = scr_at_refg_2dig(zz);                
               
               }
            }
            
    }
}

//===

