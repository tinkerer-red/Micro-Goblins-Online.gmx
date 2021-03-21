///@description chunk_tile_free(x,y,[layer])
///@param x
///@param y
///@param layer


if (argument_count = 3){
  
  //define which grid we're going to use to check
  var _layer = argument[2];
  switch (_layer){
    case "layer_heightmap": var grid_string = "heightmap_grid"; break;
    case "layer_structures": var grid_string = "structure_grid"; break;
    case "layer_obsticals": var grid_string = "obsticals_grid"; break;
    default: var grid_string = "obsticals_grid"; break;
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

var xx = argument[0] div tile_size;
var yy = argument[1] div tile_size;

//find the chunk id
if is_interior(argument[0], argument[1]){
    var array = interior_chunk_find_grid_pos(xx div width , yy div height)
    if (array = undefined){
      return true;
    }
    var grid_x = array[0]
    var grid_y = array[1]
    var map = array[2]
    
    var grid = map[? "chunk_id_grid"]
    var chunk_id = grid[# grid_x, grid_y]
    if (chunk_id = noone){
      return true;
    }
}else{
    var chunk_str = "("+string(xx div width)+","+string(yy div height)+")";
    if ds_map_exists(active_chunks, chunk_str){
      var chunk_id = active_chunks[? chunk_str]
    }else{
      return true
    }
}

    
//grab the chunk's requested grid
if variable_instance_exists(chunk_id, grid_string){
  var grid = variable_instance_get(chunk_id, grid_string);
}

//secondary check to make sure the chunk exists
if (chunk_id = noone)
|| (!instance_exists(chunk_id)){
  return false;
}

//these checks for 0 prevents dividing by 0
if (chunk_id.chunk_x*width) != 0 {
  var _chunk_x = xx mod (chunk_id.chunk_x*width)
}else{
  var _chunk_x = xx
  //these checks are just here to prevent negative number errors, with negative chunks
  if (sign(_chunk_x) = -1){  _chunk_x += width}
}
if (chunk_id.chunk_y*height) != 0 {
  var _chunk_y = yy mod (chunk_id.chunk_y*height)
}else{
  var _chunk_y = yy
  //these checks are just here to prevent negative number errors, with negative chunks
  if (sign(_chunk_y) = -1){  _chunk_y += height}
}
    
    
//get the tile
var _tile = chunk_tile_layer_find(chunk_id, _layer, _chunk_x, _chunk_y);


if (_tile = 0) return true;

return false;

