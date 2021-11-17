
//R = 1/R chances to spawn
var R = 32;
var chance = 1/R

var tile_size = global.chunk_handler.tile_size;
var width = sprite_width/tile_size + 2
var height = sprite_height/tile_size + 2

var grid = ds_grid_create(width, height)

var value = gold_noise(global.chunk_handler.world_seed, chunk_x, chunk_y)

if (value < chance){
  var closest_x = 0
  var closest_y = 0
  var dist = width+height
  
  //find the average height of the chunk
  var _mean = ds_grid_get_mean(heightmap_grid, 1, 1, width-1, height-1);
  
  
  
  // now cycle through every cell in the chunk, comparing them all to the average
  for (var xx = 1; xx < width-1; xx++) {
    for (var yy = 1; yy < height-1; yy++) {
      var temp_dist = abs(_mean - heightmap_grid[#xx,yy])
      
      //if the difference between the current cell, and the average is less then what we currently have stored, remember this location.
      //that way we are always going to try to put a dungeon on the most average location.
      if (temp_dist < dist){
        dist = temp_dist
        var closest_x = xx;
        var closest_y = yy;
      }
    }
  }
  //*/
  
  
  //bring the decemal value to our size value
  var size = ceil(value*R*3)
  
  switch (size)
    {
      case 1: 
        grid[# closest_x, closest_y] = 1; 
      break;
      
      case 2: 
        if (closest_x = 1) {closest_x++}
        if (closest_y = 1) {closest_y++}
        ds_grid_set_region(grid, closest_x-1, closest_y-1, closest_x, closest_y, 2);
      break; 
      
      case 3:
        if (closest_x = 1) {closest_x++}
        if (closest_y = 1) {closest_y++}
        if (closest_x = width-2) {closest_x--}
        if (closest_y = height-2) {closest_y--}
        ds_grid_set_region(grid, closest_x-1, closest_y-1, closest_x+1, closest_y+1, 3);
      break;
      
      /* unused for now
      case 4:
          grid[# closest_x, closest_y] = 4;
      break;
      */
    }
  
  
}


return grid
