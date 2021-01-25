///scr_gen_2dig(oc, pers, wm, lac, isIsland, refined, perc)

/*
oc = 
pers = 
wm = 
lac = 
isIsland = 
refined = 
perc = 
*/

/*
Octaves - How many layers of noise will be summarised for the final output. More octave, more errosion.
Persistence - How fast amplitude of each new octave will diminish. Higher values = more random generation.
Lacunarity - How much frequency of each new octave will increase. Lower values = smoother islands \ terrain.
Is island - If 1, elliptical gradient is applied and island will be generated. If 0, full room terrain will be ganerated.

Wavelength modifier is basically a Chunk Size. 
At 1 the chunk for generation will be = grid width / 1.
2 = grid width / 2. Etc.
2 - 4 is optimal for good looking islands. 
But if you want more eroded islands or more smaller details for full room terrain, you can try higher numbers.
*/


var oc = argument0;
var pers = argument1;
var wm = argument2;
var lac = argument3;
var isIsland = argument4;
var refined = argument5;
var perc = argument6

var tile_size = global.chunk_handler.tile_size;
var grid_size_x = (sprite_width/tile_size);
var grid_size_y = (sprite_height/tile_size);

var world_width  = global.chunk_handler.world_width  /tile_size
var world_height = global.chunk_handler.world_height /tile_size

//seed = global.chunk_handler.world_seed
//var world_heightmap = global.chunk_handler.world_heightmap
//landmass = gpu_noise_offset(world_heightmap, x, y);
//var array = gpu_noise_2d(world_heightmap, x, y)
//show_debug_message(array)

var x_off = bbox_left/tile_size
var y_off = bbox_top/tile_size

var grid = ds_grid_create(grid_size_x, grid_size_y)

var left   = bbox_left/tile_size
var right  = bbox_right/tile_size
var top    = bbox_top/tile_size
var bottom = bbox_bottom/tile_size

for(var i = left; i < right; i++){
    for(var j = top; j < bottom; j++){
            
//            if(isIsland == 1){ // Generate island by subtracting elliptical gradient from main noise.
            
//                if(refined == 0){ // If autotiling isn't needed, continue normally.
                    //var zz = 1;
                    //var zz = clamp((scr_value_2dig(i, j, oc, pers, wm, lac, grid) - elliptical_gradient(i, j, world_width, world_height, perc)),0,1);
                    var zz = clamp(scr_vn_noise(0, 1, oc, pers, 0.03125, i, j) - elliptical_gradient(i, j, world_width, world_height, perc),0,1);
                    //var zz = clamp((gpu_noise_2d(landmass, i, j) - elliptical_gradient(i, j, world_width, world_height, perc)),0,1);
                    //var zz = gpu_noise_2d(landmass, i, j);
                    //var zz = clamp((0.8 - elliptical_gradient(i, j, world_width, world_height, perc)),0,1);
                    grid[# i-x_off, j-y_off] = zz;
                    /*
                    Due to nature of the elliptical gradient equation, it could be something like: 
                    0.5 - 0.7 = -0.2, 
                    so clamp the output within your range.
                    */
//                }
                
//            } else { // Generate full landmass.
            
//                if(refined == 0){ // If autotiling isn't needed, continue normally.
                
//                    var zz = scr_value_2dig(i, j, oc, pers, wm, lac, grid);
//                    grid[# i-x_off, j-y_off] = zz;
                    
//               }
//            }
            
    }
}


//    gpu_noise_free(landmass)

//===
return grid;
