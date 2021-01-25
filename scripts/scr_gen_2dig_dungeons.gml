
var R = 32;
var chance = 1/R

var tile_size = global.chunk_handler.tile_size;
var width = sprite_width/tile_size
var height = sprite_height/tile_size

var grid = ds_grid_create(width, height)

var value = scr_noise_2dig(chunk_x, chunk_y)

if (value < chance){
  var closest_x = 0
  var closest_y = 0
  var dist = width+height
  
  var _mean = ds_grid_get_mean(heightmap_grid, 0, 0, width, height);
  
  for (var xx = 0; xx < width; xx++) {
    for (var yy = 0; yy < height; yy++) {
      var temp_dist = abs(_mean - heightmap_grid[#xx,yy])
      if (temp_dist < dist){
        dist = temp_dist
        var closest_x = xx;
        var closest_y = yy;
      }
    }
  }
  
  var size = ceil(value*R*3)
  switch (size)
    {
      case 1: 
        grid[# closest_x, closest_y] = 1; 
      break;
      
      case 2: 
        if (closest_x = 0) {closest_x++}
        if (closest_y = 0) {closest_y++}
        ds_grid_set_region(grid, closest_x-1, closest_y-1, closest_x, closest_y, 2);
      break; 
      
      case 3:
        if (closest_x = 0) {closest_x++}
        if (closest_y = 0) {closest_y++}
        if (closest_x = width) {closest_x--}
        if (closest_y = height) {closest_y--}
        ds_grid_set_region(grid, closest_x-1, closest_y-1, closest_x+1, closest_y+1, 3);
      break;
      
      case 4:
          grid[# closest_x, closest_y] = 4;
      break;
    }
  
  
}


return grid
