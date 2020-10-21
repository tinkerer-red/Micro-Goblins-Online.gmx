var zz = argument0;
var r=0,b=0,g=0;

// Commented part can be used for more common "heightmap"-like colors, 
// with blue "water" below certain limit.
/*
var water = 0.2;

zcolor = zz * 150; // Basic range values are too low for rgb, so multiply them by 100-150.

if(zz < water){
    b = zcolor + 40;
}else{
    g = zcolor;
}
*/

// 0.2 is default water level. For landmass generation, i recommend to change it to 0.3-0.4, 
// and adjust other values appropriately.
if(zz <= 0.2){r = 13; g = 33; b = 133;}
else if(zz > 0.2 && zz < 0.25){r = 223; g = 187; b = 82;}
else if(zz >= 0.25 && zz <= 0.6){r = 58; g = 93; b = 21;}
else if(zz > 0.6 && zz <= 0.7){r = 82; g = 61; b = 45;}
else if(zz > 0.7 && zz <= 0.8){r = 98; g = 98; b = 98;}
else if(zz > 0.8){r = 249; g = 250; b = 250;}

return make_color_rgb(r,g,b);
