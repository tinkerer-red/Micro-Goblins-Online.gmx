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

//var world_heightmap = global.chunk_handler.world_heightmap
//var landmass = gpu_noise_offset(world_heightmap, x*2, y*2);

var x_off = bbox_left/tile_size
var y_off = bbox_top/tile_size

//seed = global.chunk_handler.world_seed
//var array = gpu_noise_2d(world_heightmap, x, y)
//show_debug_message(array)
var grid = ds_grid_create(grid_size_x, grid_size_y)

for(var i = bbox_left/tile_size; i < bbox_right/tile_size; i++){
    for(var j = bbox_top/tile_size; j < bbox_bottom/tile_size; j++){
            
            if(isIsland == 1){ // Generate island by subtracting elliptical gradient from main noise.
            
                if(refined == 0){ // If autotiling isn't needed, continue normally.
                
                    var zz = clamp((scr_value_2dig(i, j, oc, pers, wm, lac, grid) - elliptical_gradient(i, j, world_width, world_height, perc)),0,1);
                    //var zz = clamp((gpu_noise_2d(landmass, i, j) - elliptical_gradient(i, j, world_width, world_height, perc)),0,1);
                    //var zz = clamp((0.8 - elliptical_gradient(i, j, world_width, world_height, perc)),0,1);
                    grid[# i-x_off, j-y_off] = zz;
                    /*
                    Due to nature of the elliptical gradient equation, it could be something like: 
                    0.5 - 0.7 = -0.2, 
                    so clamp the output within your range.
                    */
                    
                }
                
            } else { // Generate full landmass.
            
                if(refined == 0){ // If autotiling isn't needed, continue normally.
                
                    var zz = gpu_noise_2d(landmass, i, j);
                    grid[# i-x_off, j-y_off] = zz;
                    
               }
            }
            
    }
}

//    gpu_noise_free(landmass)

//===
return grid;
