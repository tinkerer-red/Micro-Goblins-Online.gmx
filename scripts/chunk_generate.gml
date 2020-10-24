///chunk_generate()

//should be called only by the chunk it's self

// let future scripts know this is a new cell, to prevent map comparasons.
generated = true;


/*
//Create the map and grids for saving
var tile_size = 16
var grid_size_x = (sprite_width/tile_size)
var grid_size_y = (sprite_height/tile_size)

var _map = ds_map_create();

tile_layer_bottom_grid = ds_grid_create(grid_size_x, grid_size_y);
tile_layer_middle_grid = ds_grid_create(grid_size_x, grid_size_y);
tile_layer_top_grid = ds_grid_create(grid_size_x, grid_size_y);
tile_layer_decor_grid = ds_grid_create(grid_size_x, grid_size_y);
tile_layer_bottom_background_grid = ds_grid_create(grid_size_x, grid_size_y);
tile_layer_middle_background_grid = ds_grid_create(grid_size_x, grid_size_y);
tile_layer_top_background_grid = ds_grid_create(grid_size_x, grid_size_y);
tile_layer_decor_background_grid = ds_grid_create(grid_size_x, grid_size_y);
*/

///replace this with perlin noise later
/*
heightmap_grid = ds_grid_create(16, 16)
structures_grid = ds_grid_create(16, 16)
ds_grid_clear(heightmap_grid, 0)
ds_grid_clear(structures_grid, 0)
*/

heightmap_grid = scr_gen_2dig(2, 0.25, 0.125, 2.1042, 1, 0, 0.6); // Octaves, Persistence, Wavelength Modifier, Lacunarity, Is island, Refined and AutoTiled, elliptical gradient percent


//structures_grid = scr_gen_2dig(1, 0.5, 0.05, 2.1042, 1, 0, 0.8); // Octaves, Persistence, Wavelength Modifier, Lacunarity, Is island, Refined and AutoTiled, elliptical gradient percent

//humidity_grid = scr_gen_2dig(1, 0.6, 0.0625, 2.1042, 0, 0, 0.6); // Octaves, Persistence, Wavelength Modifier, Lacunarity, Is island, Refined and AutoTiled, elliptical gradient percent
//temperature_grid = scr_gen_2dig(1, 0.4, 0.03125, 2.1042, 0, 0, 0.6); // Octaves, Persistence, Wavelength Modifier, Lacunarity, Is island, Refined and AutoTiled, elliptical gradient percent

/*
      ds_grid_clear(tile_layer_bottom_grid, -1)
      ds_grid_clear(tile_layer_middle_grid, -1)
      ds_grid_clear(tile_layer_top_grid, -1)
      ds_grid_clear(tile_layer_decor_grid, -1)
      ds_grid_clear(tile_layer_bottom_background_grid, -1)
      ds_grid_clear(tile_layer_middle_background_grid, -1)
      ds_grid_clear(tile_layer_top_background_grid, -1)
      ds_grid_clear(tile_layer_decor_background_grid, -1)
*/
///////////////////////////////////////

/*
//Store the grids into the chunk map
ds_map_add(_map, "TileLayerBottom", ds_grid_write(tile_layer_bottom_grid));
ds_map_add(_map, "TileLayerMiddle", ds_grid_write(tile_layer_middle_grid));
ds_map_add(_map, "TileLayerTop", ds_grid_write(tile_layer_top_grid));
ds_map_add(_map, "TileLayerDecor", ds_grid_write(tile_layer_decor_grid));

ds_map_add(_map, "TileLayerBottomBackground", ds_grid_write(tile_layer_bottom_background_grid));
ds_map_add(_map, "TileLayerMiddleBackground", ds_grid_write(tile_layer_middle_background_grid));
ds_map_add(_map, "TileLayerTopBackground", ds_grid_write(tile_layer_top_background_grid));
ds_map_add(_map, "TileLayerDecorBackground", ds_grid_write(tile_layer_decor_background_grid));
*/



//return _map;





