///ds_grid_add_with_fallout(1d_array_of[grids], persistence)

//returns a grid populated with the list of grids data with a predefined fall out (persistance)



var array = argument[0],
    persistence = argument[1],
    _p = 1,
    octaves = array_length_1d(array),
    maxamp = 0;

var grid = array[0],
    width = ds_grid_width(grid),
    height = ds_grid_height(grid),
    grid_temp = ds_grid_create(ds_grid_width(grid), ds_grid_height(grid));

//add all grids togething with fallout
for (var i=0; i < octaves; ++i){
  grid = array[i]
  for (var xx=0; xx < width; xx++){
    for (var yy=0; yy < height; yy++){
//      if (i = 0){
//        grid_temp[# xx, yy] = (grid_temp[# xx, yy]*2-1) + ((grid[# xx, yy]*2-1)*_p)
//      }else{
        grid_temp[# xx, yy] += (grid[# xx, yy]*2-1)*_p
//      }
    }
  }
  maxamp += _p
  _p *= persistence
}

//now divide the entire region 
for (var xx=0; xx < width; xx++){
  for (var yy=0; yy < height; yy++){
    grid_temp[# xx, yy] = ((grid_temp[# xx, yy])+1)/2 / maxamp;
    //if (grid_temp[# xx, yy] > 1) show_message_async("grid_temp[# xx, yy] = "+string(grid_temp[# xx, yy]));
  }
}

return grid_temp;
