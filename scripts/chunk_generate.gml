///chunk_generate()

//should be called only by the chunk it's self

// let future scripts know this is a new cell, to prevent map comparasons.
generated = true;

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

///replace this with perlin noise later
      ds_grid_clear(tile_layer_bottom_grid, -1)
      ds_grid_clear(tile_layer_middle_grid, -1)
      ds_grid_clear(tile_layer_top_grid, -1)
      ds_grid_clear(tile_layer_decor_grid, -1)
      ds_grid_clear(tile_layer_bottom_background_grid, -1)
      ds_grid_clear(tile_layer_middle_background_grid, -1)
      ds_grid_clear(tile_layer_top_background_grid, -1)
      ds_grid_clear(tile_layer_decor_background_grid, -1)
///////////////////////////////////////

ds_map_add(_map, "TileLayerBottom", ds_grid_write(tile_layer_bottom_grid));
ds_map_add(_map, "TileLayerMiddle", ds_grid_write(tile_layer_middle_grid));
ds_map_add(_map, "TileLayerTop", ds_grid_write(tile_layer_top_grid));
ds_map_add(_map, "TileLayerDecor", ds_grid_write(tile_layer_decor_grid));

ds_map_add(_map, "TileLayerBottomBackground", ds_grid_write(tile_layer_bottom_background_grid));
ds_map_add(_map, "TileLayerMiddleBackground", ds_grid_write(tile_layer_middle_background_grid));
ds_map_add(_map, "TileLayerTopBackground", ds_grid_write(tile_layer_top_background_grid));
ds_map_add(_map, "TileLayerDecorBackground", ds_grid_write(tile_layer_decor_background_grid));




return _map;





