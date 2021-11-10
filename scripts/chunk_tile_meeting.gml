///@description chunk_tile_meeting(x, y, ["layer"])
///@param x
///@param y
///@param layer

/*
Layer Types
  layer_heightmap  = 
  layer_structures = 
  layer_obsticals  = 
*/

//_checker = obj_precise_tile_checker;
//if(!instance_exists(_checker)) instance_create(0,0,_checker); 



//define the layer to check
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
  
  
  
  
  
  for(var _x = _x1; _x <= _x2; _x += one_tile){
    for(var _y = _y1; _y <= _y2; _y += one_tile){
      
      
      //find the chunk id
      if is_interior(argument0, argument1){
          var array = interior_chunk_find_grid_pos(_x div width , _y div height)
          if (array = undefined){
            return false;
          }
          var grid_x = array[0]
          var grid_y = array[1]
          var map = array[2]
          
          var grid = map[? "chunk_id_grid"]
          var chunk_id = grid[# grid_x, grid_y]
          if (chunk_id = noone){
            return false;
          }
      }else{
          var chunk_str = "("+string(_x div width)+","+string(_y div height)+")";
          if ds_map_exists(active_chunks, chunk_str){
            var chunk_id = active_chunks[? chunk_str]
          }else{
            return false
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
      
      //if the tile is anything except 0
      if(_tile){
        //check the tile posssition relative to the player
        xx = (chunk_id.sprite_width*chunk_id.chunk_x)+(_chunk_x*tile_size);
        yy = (chunk_id.sprite_height*chunk_id.chunk_y)+(_chunk_y*tile_size);
       if(collision_rectangle(xx,yy, xx+one_tile, yy+one_tile, self, false, false)){
         return true;
       }
      }
    }
  }
  return false;

  
  
  
































