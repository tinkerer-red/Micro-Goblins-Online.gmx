///chunk_generate()

//should be called only by the chunk it's self

// let future scripts know this is a new cell, to prevent map comparasons.
generated = true;

/*
show_debug_message("Gold Noise VVV")
timer_start()
var zz, least, most, array;
most = 0;
least = 1;
array[0] = 0;array[1] = 0;array[2] = 0;array[3] = 0;array[4] = 0;array[5] = 0;array[6] = 0;array[7] = 0;array[8] = 0;array[9] = 0;array[10] = 0;

for(var s = 0; s < 1028; s++) for(var i = 0; i < 256; i++) for(var j = 0; j < 256; j++){
  zz = hash_reed(s, i, j)
  if (zz < least) least = zz;
  if (zz > most) most = zz;
  array[floor(zz*10)]++
}
show_debug_message(array)
show_debug_message("least = "+string_format(least, 1,10))
show_debug_message("most = "+string_format(most, 1,10))
timer_end()

show_debug_message("hash12 VVV")
timer_start()
repeat(390){
for(var i = 0; i < 256; i++){
hash_reed(i, i)
}
}
timer_end()
//*/

var grid_array;

//show_debug_message("grid 0 VVV")
//timer_start()
grid_array[0] = scr_gen_2dig(1, 0.6, 0.015625*2, 2.1042, 1, 0, 0.6, global.chunk_handler.world_seed, 0);
//timer_end()


//show_debug_message("grid 1 VVV")
//timer_start()
grid_array[1] = scr_gen_2dig(1, 0.6, 0.0015625*2, 2.1042/2, 1, 0, 0.6, global.chunk_handler.world_seed*11111, 0);
//timer_end()


//cellular
//show_debug_message("grid 2 VVV")
//timer_start()
array_of_cell_grids = scr_gen_cellular_noises(1, 0.6, 0.0078195, 2, 1, 0, 0.6, global.chunk_handler.world_seed);
//timer_end()






var grid0;
grid0[0] = grid_array[0]
grid0[1] = grid_array[1]
grid0[2] = array_of_cell_grids[4]
grid0[3] = array_of_cell_grids[3]
heightmap_grid = ds_grid_add_with_fallout(grid0, 0.5)// scr_gen_2dig(3, 0.6, 0.8, 2.1042, 1, 0, 0.6); // Octaves, Persistence, Wavelength Modifier, Lacunarity, Is island, Refined and AutoTiled, elliptical gradient percent

      var river_grid = array_of_cell_grids[4]

//ds_grid_print(river_grid)


//once we have our heightmap lets add in the rivers
var width  = ds_grid_width(heightmap_grid)
var height = ds_grid_height(heightmap_grid)

//river values
var river_reach = 0.1
var river_amplitude = 5
//*
for(var xx = 0; xx < width; xx++)  for(var yy = 0; yy < height; yy++){
  //first we want to manipulate the river grid to make these calculations faster
  var zz = river_grid[# xx, yy]
  if (zz <= river_reach) {
    zz = zz*river_amplitude;
    heightmap_grid[# xx, yy] = heightmap_grid[# xx, yy] + (zz - river_amplitude*river_reach)
  } else {zz = 1}
  
  //we're over writing the original grid because we will be using the same code in just a second
  river_grid[# xx, yy] = zz
  
}
//*/




var grid1;
grid1[0] = river_grid
biome_grid = ds_grid_add_with_fallout(grid1, 0.33)



var grid2;
grid2[0] = river_grid
river_grid = ds_grid_add_with_fallout(grid2, 0.33)



structure_grid = scr_gen_2dig_dungeons()





