///interior_chunk_find_grid_pos(chunk_x, chunk_y[, map [, zone]])
/*
array[0] = grid_x;
array[1] = grid_y;
array[2] = map;
*/

//init
var array;
var chunk_x = argument[0];
var chunk_y = argument[1];

var ext_chunk_x = chunk_x - global.chunk_handler.world_chunk_width
var ext_chunk_y = chunk_y


//if we only have access to the chunks location
if (argument_count < 3){
  //now find the zone
  var zones_per_col = global.chunk_handler.world_chunk_height div global.chunk_handler.interior_zone_size
  
  var zone_x = ext_chunk_x div global.chunk_handler.interior_zone_size
  var zone_y = ext_chunk_y div global.chunk_handler.interior_zone_size
  
  var zone_pos = zone_x*zones_per_col + zone_y

  
}else{  //if we have access to the map
  

  var map = argument[2]
  
  //if we have access to the map
  if (argument_count = 3){
    var zone_pos = map[? "zone_pos"]
  }else{
    //if we have access to the zone pos
    if (argument_count = 4){
      var zone_pos = argument[3]
    }
  }
  
  //then find the rest of the data we need
  var zones_per_col = global.chunk_handler.world_chunk_height div global.chunk_handler.interior_zone_size
    
  var zone_x = zone_pos div zones_per_col
  var zone_y = zone_pos mod zones_per_col
  
}




//find out if the zone is inside the list of active interiors map

if (argument_count < 3){
  var found_map = false
  
  //initial check
  var key = ds_map_find_first(global.chunk_handler.active_interior_chunks);
  var map = global.chunk_handler.active_interior_chunks[? key]
  if (map != undefined){
    if (map[? "zone_pos"] = zone_pos){
      found_map = true;
    }else{ //if we didnt find it on our initial pass, then we can loop
      
      while (key != undefined) && (found_map = false){
        key = ds_map_find_next(key, global.chunk_handler.active_interior_chunks)
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

//if we have found our map, grab the grid
var grid_x = ext_chunk_x - zone_x*global.chunk_handler.interior_zone_size;
var grid_y = ext_chunk_y - zone_y*global.chunk_handler.interior_zone_size;

//negative value check
if (sign(grid_x) = -1){  grid_x += global.chunk_handler.interior_zone_size}
if (sign(grid_y) = -1){  grid_y += global.chunk_handler.interior_zone_size}


array[0] = grid_x;
array[1] = grid_y;
array[2] = map;

return array



