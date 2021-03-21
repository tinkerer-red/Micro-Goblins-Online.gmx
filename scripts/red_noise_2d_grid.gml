///red_noise_2d_grid(oc, pers, wm, lac, isIsland, refined, perc)

/*
oc = 
pers = 0-1
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

Wavelength modifier is basically how far the grid will check neighboring grid values before smoothing. 
But if you want more eroded islands or more smaller details for full room terrain, you can try higher numbers.
*/


var oct = argument0;
var pers = argument1;
var wm = argument2;
var lac = argument3;  //how much to smooth from (0-1)
var isIsland = argument4;
var refined = argument5;
var perc = argument6



var tile_size = global.chunk_handler.tile_size;
var grid_size_x = (sprite_width/tile_size);
var grid_size_y = (sprite_height/tile_size);

var world_width  = global.chunk_handler.world_width  /tile_size
var world_height = global.chunk_handler.world_height /tile_size

var max_oct = oct*wm

//deviding these values will slow down how often repatition happens
var x_off = 0+max_oct
var y_off = 0+max_oct

var left   = bbox_left/tile_size-max_oct
var right  = bbox_right/tile_size+max_oct
var top    = bbox_top/tile_size-max_oct
var bottom = bbox_bottom/tile_size+max_oct

//create the grid we will return
var grid = ds_grid_create(grid_size_x, grid_size_y)


var amplitude = 1
var max_amp = 0

//for each layer of noise
for(var o = 1; o <= oct; o++){
  
  max_amp += amplitude
  
  //create the temp grid 
  var temp_grid = ds_grid_create(grid_size_x+x_off+x_off,grid_size_y+y_off+y_off)
  
  //populate the temp grid with noise
  for(var i = left; i < right; i++){
    for(var j = top; j < bottom; j++){
      random_set_seed(global.chunk_handler.world_seed*o + (i + j * 65536))
      var zz = random_range(0,1);
      //var zz = clamp(scr_vn_noise(0, 1, oc, amplitude, 0.03125, i, j);
      temp_grid[# i-left, j-top] = zz;
      //show_debug_message("["+string(i-left)+","+string(j-top)+"]")
    }
  }
  
  //smooth the temp grid
  //ds_grid_filter_gaussian(temp_grid, (o+1)*oct)
  
  //copy the region of the temp grid to the returned grid, each cell being multiplied by amplitude
  for(var i = 0; i < ds_grid_width(grid); i++){
    for(var j = 0; j < ds_grid_height(grid); j++){
      grid[# i,j] += ds_grid_get_mean(temp_grid, i, j, i+x_off+x_off+wm, j+y_off+y_off+wm) * amplitude;
    }
  }
  
  //clean up old temp grid
  ds_grid_destroy(temp_grid)
  
  amplitude *= pers
  
  
  x_off -= wm
  y_off -= wm
  left += wm
  right -= wm
  top += wm
  bottom -= wm
//  lac +=
}

//normalize the values
for(var i = 0; i < ds_grid_width(grid); i++){
  for(var j = 0; j < ds_grid_height(grid); j++){
    grid[# i,j] = normalize(grid[# i,j], 0, max_amp)
  }
}

//ds_grid_filter_gaussian(grid, lac)
/*
//after we made the grid, add the gradient for islands
if (isIsland){
  for(var i = left; i < right; i++){
    for(var j = top; j < bottom; j++){
      grid[# i-left,j-top] = clamp(grid[# i-left,j-top] - elliptical_gradient(i, j, world_width, world_height, perc),0,1)
    }
  }
}
*/
//===
return grid;
