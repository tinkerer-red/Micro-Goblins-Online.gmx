///@description chunk_tile_meeting_precise(x, y, ["layer"])
///@param x
///@param y
///@param layer

/*
Layer Types
  layer_heightmap  = 
  layer_structures = 
  layer_obsticals  = 
*/

_checker = obj_precise_tile_checker;
if(!instance_exists(_checker)) instance_create(0,0,_checker); 



if (argument_count = 3){
  //define which grid we're going to use to check
  var _layer = argument[2];
  switch (_layer){
    case "layer_heightmap":
      var grid_string = "heightmap_grid"
    break;
    case "layer_structures":
      var grid_string = "structure_grid"
    break;
    case "layer_obsticals":
      var grid_string = "obsticals_grid"
    break;
    default:
      var grid_string = "obsticals_grid"
    break;
  }
}else{//if no layer was defined assume they were talking about obstical layer
  var _layer = "layer_obsticals"
  var grid_string = "obstical_grid"
}

//grab the chunk values
var active_chunks = global.chunk_handler.active_chunks
var tile_size = global.chunk_handler.tile_size
var width = global.chunk_handler.chunk_width div tile_size
var height = global.chunk_handler.chunk_height div tile_size

//define the used variables
var margin = 8
var _x1 = (bbox_left + (argument0 - x) -margin) div tile_size;
var _y1 = (bbox_top + (argument1 - y) - margin) div tile_size;
var _x2 = (bbox_right + (argument0 - x) + margin) div tile_size;
var _y2 = (bbox_bottom + (argument1 - y) + margin) div tile_size;


for(var _x = _x1; _x <= _x2; _x++){
  for(var _y = _y1; _y <= _y2; _y++){
    //find the chunk id
    var chunk_str = "("+string(_x div width)+","+string(_y div height)+")";
    if ds_map_exists(active_chunks, chunk_str){
      var chunk_id = active_chunks[? chunk_str]
    }else{
      return false
    }
    
    //grab the chunk's requested grid
    if variable_instance_exists(chunk_id, grid_string){
      var grid = variable_instance_get(chunk_id, grid_string);
    }
    
    
    //these checks for 0 prevents dividing by 0
    if (chunk_id.chunk_x*width) != 0 {
      var _chunk_x = _x mod (chunk_id.chunk_x*width)
    }else{
      var _chunk_x = _x
    }
    if (chunk_id.chunk_y*height) != 0 {
      var _chunk_y = _y mod (chunk_id.chunk_y*height)
    }else{
      var _chunk_y = _y
    }
    
    
    //get the image for the tile
    var _tile = chunk_tile_layer_find(chunk_id, _layer, _chunk_x, _chunk_y);
    //show_debug_player(0, "_tile = "+string(_tile))
    if(_tile){
    //find out which tile sprite is being used based off this information
      _checker.sprite_index = tile_snow; 
    //check the tile posssition relative to the player
      _checker.x = (chunk_id.sprite_width*chunk_id.chunk_x)+(_chunk_x*tile_size);
      _checker.y = (chunk_id.sprite_height*chunk_id.chunk_y)+(_chunk_y*tile_size);
     if(place_meeting(argument0,argument1,_checker)) return true;
    }
  }
}

return false;

