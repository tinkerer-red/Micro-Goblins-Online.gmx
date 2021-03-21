///chunk_interior_map_exists()


/*
array[0] = grid_x;
array[1] = grid_y;
array[2] = map;
*/




//first check
if (object_index = obj_chunk){
  if variable_instance_exists(self, "interior_map"){
    return true;
  }
}else{ //if the object inst a chunk
  return false;
}





//second check
//grab the chunk values
var active_chunks = global.chunk_handler.active_chunks
var tile_size = global.chunk_handler.tile_size
var width = global.chunk_handler.chunk_width
var height = global.chunk_handler.chunk_height

//find the chunks location
var chunk_x = x div width
var chunk_y = y div height

var int_chunk_x = chunk_x - global.chunk_handler.world_chunk_width
var int_chunk_y = chunk_y

//now find the zone
var zones_per_col = global.chunk_handler.world_chunk_height div global.chunk_handler.interior_zone_size

var zone_x = int_chunk_x div global.chunk_handler.interior_zone_size
var zone_y = int_chunk_y div global.chunk_handler.interior_zone_size

var zone_pos = zone_x*zones_per_col + zone_y





//find out if the zone is inside the list of active interiors map
var found_map = false

//initial check
var key = ds_map_find_first(global.chunk_handler.active_interior_chunks);
var map = global.chunk_handler.active_interior_chunks[? key]
if (map != undefined){
  if (map[? "zone_pos"] = zone_pos){
    found_map = true;
  }else{ //if we didnt find it on our initial pass, then we can loop
    var _j = json_encode(global.chunk_handler.active_interior_chunks)
    
    while (key != undefined) && (found_map = false){
      key = ds_map_find_next(global.chunk_handler.active_interior_chunks, key)
      map = global.chunk_handler.active_interior_chunks[? key]
      if (map != undefined){
        if (map[? "zone_pos"] = zone_pos){
          found_map = true;
          break;
        }
      }
    }//end while
    
  }//end of else
}


///////////////////////////////////////////////////////////////////////////////////////////////////
          //all of the interior chunk scripts keep track of the data they collected for future use
            //save the map to the chunk
            interior_map = map
            
            //save the pos if the chunk doesn't know where that is
            if !variable_instance_exists(self, "interior_grid_x")
            || !variable_instance_exists(self, "interior_grid_y"){
              //if we have found our map, grab the grid
              var grid_x = int_chunk_x - zone_x*global.chunk_handler.interior_zone_size;
              var grid_y = int_chunk_y - zone_y*global.chunk_handler.interior_zone_size;
              
              //negative value check
              if (sign(grid_x) = -1){  grid_x += global.chunk_handler.interior_zone_size}
              if (sign(grid_y) = -1){  grid_y += global.chunk_handler.interior_zone_size}
              
              interior_grid_x = grid_x
              interior_grid_y = grid_y
            }
///////////////////////////////////////////////////////////////////////////////////////////////////


return found_map


