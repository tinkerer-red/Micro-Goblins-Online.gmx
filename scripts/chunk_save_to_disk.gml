///chunk_save_to_disk()

var tile_size = 16

_map = ds_map_create()


// Bottom
var tile_layer_bottom_list = ds_list_create()
var tile_layer_bottom_background_list = ds_list_create()
var b_layer = TileLayerBottom

// MIDDLE
var tile_layer_middle_list = ds_list_create()
var tile_layer_middle_background_list = ds_list_create()
var m_layer = TileLayerMiddle

// TOP
var tile_layer_top_list = ds_list_create()
var tile_layer_top_background_list = ds_list_create()
var t_layer = TileLayerTop

// DECOR
var tile_layer_decor_list = ds_list_create()
var tile_layer_decor_background_list = ds_list_create()
var d_layer = TileLayerDecor

// do a single cycle through the chunk
for (var i = 0; i < sprite_height; i += tile_size){
  for (var j = 0; j < sprite_width; j += tile_size){
    //bottom
    var _tile = tile_layer_find(b_layer, x+j, y+i);
    if(_tile){
      var bg = tile_get_background(_tile),
          bg_ww = background_get_width(bg),
          ww = tile_get_width(_tile),
          hh = tile_get_height(_tile),
          ll = (tile_get_left(_tile) / ww),
          tt = (tile_get_top(_tile) / hh);
      
      var pos = ll + tt*(bg_ww div ww);
    }else{
      var pos = -1
      var bg = -1
    }
    ds_list_add(tile_layer_bottom_list, pos);
    ds_list_add(tile_layer_bottom_background_list, bg);
    
    
    //middle
    var _tile = tile_layer_find(m_layer, x+j, y+i);
    if(_tile){
      var bg = tile_get_background(_tile),
          bg_ww = background_get_width(bg),
          ww = tile_get_width(_tile),
          hh = tile_get_height(_tile),
          ll = (tile_get_left(_tile) / ww),
          tt = (tile_get_top(_tile) / hh);
      
      var pos = ll + tt*(bg_ww div ww);
    }else{
      var pos = -1
      var bg  = -1
    }
    ds_list_add(tile_layer_middle_list, pos);
    ds_list_add(tile_layer_middle_background_list, bg);
    
    
    //top
    var _tile = tile_layer_find(t_layer, x+j, y+i);
    if(_tile){
      var bg = tile_get_background(_tile),
          bg_ww = background_get_width(bg),
          ww = tile_get_width(_tile),
          hh = tile_get_height(_tile),
          ll = (tile_get_left(_tile) / ww),
          tt = (tile_get_top(_tile) / hh);
      
      var pos = ll + tt*(bg_ww div ww);
    }else{
      var pos = -1
      var bg  = -1
    }
    ds_list_add(tile_layer_top_list, pos);
    ds_list_add(tile_layer_top_background_list, bg);
    
    
    //decor
    var _tile = tile_layer_find(d_layer, x+j, y+i);
    if(_tile){
      var bg = tile_get_background(_tile),
          bg_ww = background_get_width(bg),
          ww = tile_get_width(_tile),
          hh = tile_get_height(_tile),
          ll = (tile_get_left(_tile) / ww),
          tt = (tile_get_top(_tile) / hh);
      
      var pos = ll + tt*(bg_ww div ww);
    }else{
      var pos = -1;
      var bg  = -1;
    }
    ds_list_add(tile_layer_decor_list, pos);
    ds_list_add(tile_layer_decor_background_list, bg);
    
  }
}


// Compile Map
ds_map_add_list(_map, "TileLayerBottom", tile_layer_bottom_list)
ds_map_add_list(_map, "TileLayerMiddle", tile_layer_middle_list)
ds_map_add_list(_map, "TileLayerTop", tile_layer_top_list)
ds_map_add_list(_map, "TileLayerDecor", tile_layer_decor_list)


// Save
var _filename = "Worlds\"+string(world_name)+"\"+string(chunk_x)+","+string(chunk_y)+".chnk"
var async_array = file_save_map_async(_filename, _map)
//show_debug_message("async_array[0] = "+string(async_array[0]))
//show_debug_message("async_array[1] = "+string(async_array[1]))
ds_priority_add(global.chunk_handler.saving_async, async_array[0], async_array[1])
//var _json = json_encode(_map)
//var file = file_text_open_write(_filename)
//file_text_write_string(file, _json)
//file_text_close(file)

// Clean Up
ds_map_destroy(_map)


