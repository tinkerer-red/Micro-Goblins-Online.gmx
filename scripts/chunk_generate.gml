///chunk_generate()

//should be called only by the chunk it's self

var tile_size = 16
var list_size = (sprite_width/tile_size)*(sprite_height/tile_size)

var _map = ds_map_create();

tile_layer_bottom_list = ds_list_create();
tile_layer_middle_list = ds_list_create();
tile_layer_top_list = ds_list_create();
tile_layer_decor_list = ds_list_create();
tile_layer_bottom_background_list = ds_list_create();
tile_layer_middle_background_list = ds_list_create();
tile_layer_top_background_list = ds_list_create();
tile_layer_decor_background_list = ds_list_create();

repeat(list_size){
  ds_list_add(tile_layer_bottom_list, -1)
  ds_list_add(tile_layer_middle_list, -1)
  ds_list_add(tile_layer_top_list, -1)
  ds_list_add(tile_layer_decor_list, -1)
  ds_list_add(tile_layer_bottom_background_list, -1)
  ds_list_add(tile_layer_middle_background_list, -1)
  ds_list_add(tile_layer_top_background_list, -1)
  ds_list_add(tile_layer_decor_background_list, -1)
}

ds_map_add_list(_map, "TileLayerBottom", tile_layer_bottom_list);
ds_map_add_list(_map, "TileLayerMiddle", tile_layer_middle_list);
ds_map_add_list(_map, "TileLayerTop", tile_layer_top_list);
ds_map_add_list(_map, "TileLayerDecor", tile_layer_decor_list);

ds_map_add_list(_map, "TileLayerBottomBackground", tile_layer_bottom_background_list);
ds_map_add_list(_map, "TileLayerMiddleBackground", tile_layer_middle_background_list);
ds_map_add_list(_map, "TileLayerTopBackground", tile_layer_top_background_list);
ds_map_add_list(_map, "TileLayerDecorBackground", tile_layer_decor_background_list);



return _map;
