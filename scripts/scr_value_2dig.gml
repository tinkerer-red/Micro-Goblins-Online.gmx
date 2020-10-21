// Coherent "Value" noise function.
var xx = argument0;
var yy = argument1;
var octaves = argument2;
var pers = argument3;
var wm = argument4;
var lac = argument5;
var grid = argument6

var value = 0;

var freq = 1 / (ds_grid_width(grid) / wm); // Frequency of starting octave.
var amp = pers;

var namp = 0; // Amplitude normalisation variable

for(var z =  0; z < octaves; z++){
    
    namp += amp;
               
    value += scr_interpolated_2dig(xx * freq, yy * freq) * amp;  
            
    freq *= lac;
    amp *= pers;
            
    fv = value / namp; // Basic range normalisation.
               
}

return fv;

