///chunk_save_to_disk()
//*
var tile_size = 16
var chunk_width = sprite_width/tile_size;
var chunk_height = sprite_height/tile_size;

_map = ds_map_create()


// Bottom
//var tile_layer_bottom_grid = ds_grid_create()
//var tile_layer_bottom_background_grid = ds_grid_create()
var b_layer = TileLayerBottom

// MIDDLE
//var tile_layer_middle_grid = ds_grid_create()
//var tile_layer_middle_background_grid = ds_grid_create()
var m_layer = TileLayerMiddle

// TOP
//var tile_layer_top_grid = ds_grid_create()
//var tile_layer_top_background_grid = ds_grid_create()
var t_layer = TileLayerTop

// DECOR
//var tile_layer_decor_grid = ds_grid_create()
//var tile_layer_decor_background_grid = ds_grid_create()
var d_layer = TileLayerDecor

// do a single cycle through the chunk
for (var i = 0; i < chunk_width; i++){
  for (var j = 0; j < chunk_height; j++){
    //bottom
    var _tile = tile_layer_find(b_layer, x+i*tile_size, y+j*tile_size);
    if(_tile){
      var bg = tile_get_background(_tile),
          bg_ww = background_get_width(bg),
          ll = (tile_get_left(_tile) / tile_size),
          tt = (tile_get_top(_tile) / tile_size);
      
      var pos = ll + tt*(bg_ww div tile_size);
    }else{
      var pos = -1
      var bg = -1
    }
    tile_layer_bottom_grid[# i, j] = pos;
    tile_layer_bottom_background_grid[# i, j] = bg;
    
    
    //middle
    var _tile = tile_layer_find(m_layer, x+i*tile_size, y+j*tile_size);
    if(_tile){
      var bg = tile_get_background(_tile),
          bg_ww = background_get_width(bg),
          ll = (tile_get_left(_tile) / tile_size),
          tt = (tile_get_top(_tile) / tile_size);
      
      var pos = ll + tt*(bg_ww div tile_size);
    }else{
      var pos = -1
      var bg  = -1
    }
    tile_layer_middle_grid[# i, j] = pos;
    tile_layer_middle_background_grid[# i, j] = bg;
    
    
    //top
    var _tile = tile_layer_find(t_layer, x+i*tile_size, y+j*tile_size);
    if(_tile){
      var bg = tile_get_background(_tile),
          bg_ww = background_get_width(bg),
          ll = (tile_get_left(_tile) / tile_size),
          tt = (tile_get_top(_tile) / tile_size);
      
      var pos = ll + tt*(bg_ww div tile_size);
    }else{
      var pos = -1
      var bg  = -1
    }
    tile_layer_top_grid[# i, j] = pos;
    tile_layer_top_background_grid[# i, j] = bg;
    
    
    //decor
    var _tile = tile_layer_find(d_layer, x+i*tile_size, y+j*tile_size);
    if(_tile){
      var bg = tile_get_background(_tile),
          bg_ww = background_get_width(bg),
          ll = (tile_get_left(_tile) / tile_size),
          tt = (tile_get_top(_tile) / tile_size);
      
      var pos = ll + tt*(bg_ww div tile_size);
    }else{
      var pos = -1;
      var bg  = -1;
    }
    tile_layer_decor_grid[# i, j] = pos;
    tile_layer_decor_background_grid[# i, j] = bg;
    
  }
}
//*/

var update_world_map = false;

// Compile Map
var grid_write = ds_grid_write(tile_layer_bottom_grid);
    if (chunk_data[? "TileLayerBottom"] != grid_write) {
        chunk_data[? "TileLayerBottom"] = grid_write
        update_world_map = true;
    }
var grid_write = ds_grid_write(tile_layer_middle_grid);
    if (chunk_data[? "TileLayerMiddle"] != grid_write) {
        chunk_data[? "TileLayerMiddle"] = grid_write
        update_world_map = true;
    }
var grid_write = ds_grid_write(tile_layer_top_grid);
    if (chunk_data[? "TileLayerTop"] != grid_write) {
        chunk_data[? "TileLayerTop"] = grid_write
        update_world_map = true;
    }
var grid_write = ds_grid_write(tile_layer_decor_grid);
    if (chunk_data[? "TileLayerDecor"] != grid_write) {
        chunk_data[? "TileLayerDecor"] = grid_write
        update_world_map = true;
    }


var grid_write = ds_grid_write(tile_layer_bottom_background_grid);
    if (chunk_data[? "TileLayerBottomBackground"] != grid_write) {
        chunk_data[? "TileLayerBottomBackground"] = grid_write
        update_world_map = true;
    }
var grid_write = ds_grid_write(tile_layer_middle_background_grid);
    if (chunk_data[? "TileLayerMiddleBackground"] != grid_write) {
        chunk_data[? "TileLayerMiddleBackground"] = grid_write
        update_world_map = true;
    }
var grid_write = ds_grid_write(tile_layer_top_background_grid);
    if (chunk_data[? "TileLayerTopBackground"] != grid_write) {
        chunk_data[? "TileLayerTopBackground"] = grid_write
        update_world_map = true;
    }
var grid_write = ds_grid_write(tile_layer_decor_background_grid);
    if (chunk_data[? "TileLayerDecorBackground"] != grid_write) {
        chunk_data[? "TileLayerDecorBackground"] = grid_write
        update_world_map = true;
    }


///Update world ds_map
if (update_world_map = true) || (generated = true){
    var map_write = ds_map_write(chunk_data);
    //var map_base64 = hex_to_b64(map_write)
    global.chunk_handler.world_map[? string(chunk_x)+","+string(chunk_y)] = map_write;
}

// Save
//var _filename = "Worlds\"+string(world_name)+"\"+string(chunk_x)+","+string(chunk_y)+".chnk"
//var async_array = 
//file_save_map_async(_filename, chunk_data)
//show_debug_map(chunk_data)

//file_save_map(_filename, chunk_data)
//ds_priority_add(global.chunk_handler.saving_async, async_array[0], async_array[1])
//ds_priority_add(global.chunk_handler.saving_async_maps, async_array[0], chunk_data)

//ds_map_destroy(_map)

////The old file saving system, which is not async
//var _json = json_encode(_map)
//var file = file_text_open_write(_filename)
//file_text_write_string(file, _json)
//file_text_close(file)






