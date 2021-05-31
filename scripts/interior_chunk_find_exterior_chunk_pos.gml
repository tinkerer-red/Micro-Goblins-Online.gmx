///interior_chunk_find_exterior_chunk_pos(chunk_x, chunk_y[, map])


/*
array[0] = exterior_chunk_x;
array[1] = exterior_chunk_y;
array[2] = map;
*/




//init
var array;
var chunk_x = argument[0];
var chunk_y = argument[1];

if (object_index = obj_chunk){
  if variable_instance_exists(self, "interior_map")
  && variable_instance_exists(self, "interior_grid_x")
  && variable_instance_exists(self, "interior_grid_y"){
    array[0] = interior_grid_x;
    array[1] = interior_grid_y;
    array[2] = interior_map;
  }
}

var int_chunk_x = chunk_x - global.chunk_handler.world_chunk_width
var int_chunk_y = chunk_y


//if we only have access to the chunks location
if (argument_count < 3){
  //now find the zone
  var zones_per_col = global.chunk_handler.world_chunk_height div global.chunk_handler.interior_zone_size
  
  var zone_x = int_chunk_x div global.chunk_handler.interior_zone_size
  var zone_y = int_chunk_y div global.chunk_handler.interior_zone_size
  
  var zone_pos = zone_x*zones_per_col + zone_y

  
}else{  //if we have access to the map
  var map = argument[2]
}




//find out if the zone is inside the list of active interiors maps
if (argument_count < 3){
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
  
  if (found_map = false){  return undefined;  }
}


//if the map was supplied we can basically assume it's there, of course we can always double check
if (map[? "zone_pos"] != zone_pos){
    return undefined;
}

//now that we have the map from all possible source options, we need to get the exit location
var ext_x = map[? "exit_x"];
var ext_y = map[? "exit_y"] - one_tile;

var ext_array = xy_to_chunk(ext_x, ext_y);


array[0] = ext_array[0];
array[1] = ext_array[1];
array[2] = map;

return array



